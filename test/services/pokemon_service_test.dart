import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:claude_learning/services/http_client.dart';
import 'package:claude_learning/services/pokemon_service.dart';

// Manual mock — build_runner 2.14.x incompatible with Dart 3.10 aot-snapshot.
// Parameter is String? (nullable) so mockito's `any` matcher (returns null)
// can be passed in when(...) calls — same pattern the code generator uses.
class MockHttpClient extends Mock implements HttpClient {
  @override
  Future<String> get(String? url) => super.noSuchMethod(
        Invocation.method(#get, [url]),
        returnValue: Future<String>.value(''),
        returnValueForMissingStub: Future<String>.value(''),
      ) as Future<String>;
}

void main() {
  late MockHttpClient mockClient;
  late PokemonService service;

  setUp(() {
    mockClient = MockHttpClient();
    service = PokemonService(mockClient);
  });

  String loadFixture() =>
      File('test/fixtures/ditto_response.json').readAsStringSync();

  group('PokemonService.fetchPokemon', () {
    test('returns Pokemon on HTTP 200 with valid JSON', () async {
      when(mockClient.get(any)).thenAnswer((_) async => loadFixture());

      final pokemon = await service.fetchPokemon('ditto');

      expect(pokemon.name, 'ditto');
      expect(pokemon.id, 132);
    });

    test('throws PokemonNotFoundException when body is empty', () async {
      when(mockClient.get(any)).thenAnswer((_) async => '');

      expect(
        () => service.fetchPokemon('unknown'),
        throwsA(isA<PokemonNotFoundException>()),
      );
    });

    test('throws PokemonNotFoundException when JSON is invalid', () async {
      when(mockClient.get(any)).thenAnswer((_) async => 'not-json');

      expect(
        () => service.fetchPokemon('ditto'),
        throwsA(isA<PokemonNotFoundException>()),
      );
    });

    test('throws NetworkException when client throws', () async {
      when(mockClient.get(any)).thenThrow(Exception('connection refused'));

      expect(
        () => service.fetchPokemon('ditto'),
        throwsA(isA<NetworkException>()),
      );
    });

    test('NetworkException message wraps original error', () async {
      when(mockClient.get(any)).thenThrow(Exception('timeout'));

      try {
        await service.fetchPokemon('ditto');
        fail('should have thrown');
      } on NetworkException catch (e) {
        expect(e.toString(), contains('timeout'));
      }
    });

    test('PokemonNotFoundException includes pokemon name', () async {
      when(mockClient.get(any)).thenAnswer((_) async => '');

      try {
        await service.fetchPokemon('missingno');
        fail('should have thrown');
      } on PokemonNotFoundException catch (e) {
        expect(e.toString(), contains('missingno'));
      }
    });
  });

  group('PokemonService constructor', () {
    test('accepts HttpClient via constructor injection', () {
      expect(PokemonService(mockClient), isA<PokemonService>());
    });
  });
}
