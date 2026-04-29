import 'dart:convert';

import '../models/pokemon.dart';
import 'http_client.dart';

class PokemonNotFoundException implements Exception {
  final String name;
  const PokemonNotFoundException(this.name);

  @override
  String toString() => 'PokemonNotFoundException: "$name" not found';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class PokemonService {
  final HttpClient _client;

  const PokemonService(this._client);

  Future<Pokemon> fetchPokemon(String name) async {
    final url = 'https://pokeapi.co/api/v2/pokemon/$name';
    final String body;

    try {
      body = await _client.get(url);
    } catch (e) {
      throw NetworkException(e.toString());
    }

    if (body.isEmpty) {
      throw PokemonNotFoundException(name);
    }

    try {
      final json = jsonDecode(body) as Map<String, dynamic>;
      return Pokemon.fromJson(json);
    } catch (_) {
      throw PokemonNotFoundException(name);
    }
  }
}
