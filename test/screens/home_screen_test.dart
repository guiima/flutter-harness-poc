import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:claude_learning/models/pokemon.dart';
import 'package:claude_learning/models/pokemon_move.dart';
import 'package:claude_learning/models/pokemon_stat.dart';
import 'package:claude_learning/models/pokemon_type.dart';
import 'package:claude_learning/screens/home_screen.dart';
import 'package:claude_learning/services/http_client.dart';
import 'package:claude_learning/services/pokemon_service.dart';
import 'package:claude_learning/widgets/pokemon_card.dart';

class MockHttpClient extends Mock implements HttpClient {
  @override
  Future<String> get(String? url) => super.noSuchMethod(
        Invocation.method(#get, [url]),
        returnValue: Future<String>.value(''),
        returnValueForMissingStub: Future<String>.value(''),
      ) as Future<String>;
}

Pokemon _ditto() => const Pokemon(
      id: 132,
      name: 'ditto',
      height: 3,
      weight: 40,
      spriteUrl: 'https://example.com/sprite.png',
      officialArtworkUrl: 'https://example.com/artwork.png',
      types: [PokemonType(name: 'normal')],
      stats: [PokemonStat(name: 'hp', baseStat: 48)],
      moves: [PokemonMove(name: 'transform')],
    );

Pokemon _pikachu() => const Pokemon(
      id: 25,
      name: 'pikachu',
      height: 4,
      weight: 60,
      spriteUrl: 'https://example.com/pikachu-sprite.png',
      officialArtworkUrl: 'https://example.com/pikachu-artwork.png',
      types: [PokemonType(name: 'electric')],
      stats: [PokemonStat(name: 'hp', baseStat: 35)],
      moves: [PokemonMove(name: 'thunder-shock')],
    );

void main() {
  late MockHttpClient mockClient;
  late PokemonService service;

  setUp(() {
    mockClient = MockHttpClient();
    service = PokemonService(mockClient);
  });

  group('HomeScreen — search bar', () {
    testWidgets('shows TextField with initial value "ditto"', (tester) async {
      final svc = _StubbedService(_ditto());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));

      final tf = tester.widget<TextField>(find.byType(TextField));
      expect(tf.controller?.text, 'ditto');
    });

    testWidgets('shows search icon and pokéball icon', (tester) async {
      final svc = _StubbedService(_ditto());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.catching_pokemon), findsOneWidget);
    });

    testWidgets('submitting a name via keyboard triggers search', (
      tester,
    ) async {
      final svc = _TrackingService(_pikachu());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'pikachu');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(svc.lastQuery, 'pikachu');
    });

    testWidgets('tapping search icon button triggers search', (tester) async {
      final svc = _TrackingService(_pikachu());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'pikachu');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();

      expect(svc.lastQuery, 'pikachu');
    });

    testWidgets('empty query is ignored — does not trigger search', (
      tester,
    ) async {
      final svc = _TrackingService(_ditto());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      final initialCount = svc.callCount;
      await tester.enterText(find.byType(TextField), '   ');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(svc.callCount, initialCount);
    });
  });

  group('HomeScreen — loading state', () {
    testWidgets('shows CircularProgressIndicator while fetching', (
      tester,
    ) async {
      final completer = Completer<String>();
      when(mockClient.get(any)).thenAnswer((_) => completer.future);

      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: service)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(PokemonCard), findsNothing);

      completer.completeError(Exception('cancelled'));
      await tester.pump();
    });
  });

  group('HomeScreen — success state', () {
    testWidgets('shows PokemonCard after successful fetch', (tester) async {
      final svc = _StubbedService(_ditto());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      expect(find.byType(PokemonCard), findsOneWidget);
    });

    testWidgets('displays pokemon name in card', (tester) async {
      final svc = _StubbedService(_ditto());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      expect(find.text('Ditto'), findsOneWidget);
    });

    testWidgets('card updates when a different pokemon is searched', (
      tester,
    ) async {
      final svc = _StubbedService(_pikachu());
      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: svc)));
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'pikachu');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      await tester.pump();

      expect(find.text('Pikachu'), findsOneWidget);
    });
  });

  group('HomeScreen — error state', () {
    testWidgets('shows error icon and message on network failure', (
      tester,
    ) async {
      when(mockClient.get(any)).thenThrow(Exception('network error'));

      await tester.pumpWidget(MaterialApp(home: HomeScreen(service: service)));
      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(PokemonCard), findsNothing);
    });
  });
}

// ── Test doubles ────────────────────────────────────────────────────────────

class _StubbedService extends PokemonService {
  final Pokemon _pokemon;
  _StubbedService(this._pokemon) : super(const _NoOpClient());

  @override
  Future<Pokemon> fetchPokemon(String name) async => _pokemon;
}

class _TrackingService extends PokemonService {
  final Pokemon _pokemon;
  String? lastQuery;
  int callCount = 0;

  _TrackingService(this._pokemon) : super(const _NoOpClient());

  @override
  Future<Pokemon> fetchPokemon(String name) async {
    lastQuery = name;
    callCount++;
    return _pokemon;
  }
}

class _NoOpClient implements HttpClient {
  const _NoOpClient();
  @override
  Future<String> get(String url) async => '';
}
