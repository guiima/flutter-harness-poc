import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:claude_learning/models/pokemon.dart';
import 'package:claude_learning/models/pokemon_move.dart';
import 'package:claude_learning/models/pokemon_stat.dart';
import 'package:claude_learning/models/pokemon_type.dart';
import 'package:claude_learning/screens/home_screen.dart';
import 'package:claude_learning/services/pokemon_service.dart';
import 'package:claude_learning/services/http_client.dart';
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

void main() {
  late MockHttpClient mockClient;
  late PokemonService service;

  setUp(() {
    mockClient = MockHttpClient();
    service = PokemonService(mockClient);
  });

  Widget buildScreen() => MaterialApp(home: HomeScreen(service: service));

  group('HomeScreen loading state', () {
    testWidgets('shows CircularProgressIndicator while fetching', (
      tester,
    ) async {
      // Completer that never resolves — avoids pending-timer assertion
      final completer = Completer<String>();
      when(mockClient.get(any)).thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(PokemonCard), findsNothing);

      // Drain the completer so no pending futures remain after the test
      completer.completeError(Exception('cancelled'));
      await tester.pump();
    });
  });

  group('HomeScreen success state', () {
    testWidgets('shows PokemonCard after successful fetch', (tester) async {
      when(mockClient.get(any)).thenAnswer(
        (_) async => throw UnimplementedError('use service stub'),
      );

      final stubbedService = _StubbedPokemonService(_ditto());
      await tester.pumpWidget(
        MaterialApp(home: HomeScreen(service: stubbedService)),
      );
      await tester.pump();

      expect(find.byType(PokemonCard), findsOneWidget);
    });

    testWidgets('displays pokemon name in card', (tester) async {
      final stubbedService = _StubbedPokemonService(_ditto());
      await tester.pumpWidget(
        MaterialApp(home: HomeScreen(service: stubbedService)),
      );
      await tester.pump();

      expect(find.text('Ditto'), findsOneWidget);
    });
  });

  group('HomeScreen error state', () {
    testWidgets('shows error icon and message on network failure', (
      tester,
    ) async {
      when(mockClient.get(any)).thenThrow(Exception('network error'));

      await tester.pumpWidget(buildScreen());
      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.byType(PokemonCard), findsNothing);
    });
  });
}

class _StubbedPokemonService extends PokemonService {
  final Pokemon _pokemon;

  _StubbedPokemonService(this._pokemon)
      : super(const _NoOpHttpClient());

  @override
  Future<Pokemon> fetchPokemon(String name) async => _pokemon;
}

class _NoOpHttpClient implements HttpClient {
  const _NoOpHttpClient();

  @override
  Future<String> get(String url) async => '';
}
