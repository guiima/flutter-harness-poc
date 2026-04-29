import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:claude_learning/models/pokemon.dart';
import 'package:claude_learning/models/pokemon_move.dart';
import 'package:claude_learning/models/pokemon_stat.dart';
import 'package:claude_learning/models/pokemon_type.dart';

Map<String, dynamic> _loadFixture() {
  final file = File('test/fixtures/ditto_response.json');
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

void main() {
  late Map<String, dynamic> json;
  late Pokemon ditto;

  setUp(() {
    json = _loadFixture();
    ditto = Pokemon.fromJson(json);
  });

  group('Pokemon.fromJson', () {
    test('parses id and name', () {
      expect(ditto.id, 132);
      expect(ditto.name, 'ditto');
    });

    test('parses height and weight', () {
      expect(ditto.height, 3);
      expect(ditto.weight, 40);
    });

    test('parses sprite URLs', () {
      expect(ditto.spriteUrl, contains('132.png'));
      expect(ditto.officialArtworkUrl, contains('official-artwork'));
    });

    test('parses types', () {
      expect(ditto.types, hasLength(1));
      expect(ditto.types.first.name, 'normal');
    });

    test('parses stats', () {
      expect(ditto.stats, hasLength(6));
      expect(ditto.stats.first.name, 'hp');
      expect(ditto.stats.first.baseStat, 48);
    });

    test('parses moves', () {
      expect(ditto.moves, hasLength(1));
      expect(ditto.moves.first.name, 'transform');
    });
  });

  group('Pokemon computed properties', () {
    test('hp returns hp stat value', () {
      expect(ditto.hp, 48);
    });

    test('primaryType returns first type name', () {
      expect(ditto.primaryType, 'normal');
    });
  });

  group('PokemonType.fromJson', () {
    test('parses name from nested type object', () {
      final typeJson = {'slot': 1, 'type': {'name': 'fire', 'url': ''}};
      final type = PokemonType.fromJson(typeJson);
      expect(type.name, 'fire');
    });
  });

  group('PokemonStat.fromJson', () {
    test('parses name and baseStat', () {
      final statJson = {
        'base_stat': 90,
        'effort': 0,
        'stat': {'name': 'attack', 'url': ''},
      };
      final stat = PokemonStat.fromJson(statJson);
      expect(stat.name, 'attack');
      expect(stat.baseStat, 90);
    });
  });

  group('PokemonMove.fromJson', () {
    test('parses name from nested move object', () {
      final moveJson = {'move': {'name': 'tackle', 'url': ''}};
      final move = PokemonMove.fromJson(moveJson);
      expect(move.name, 'tackle');
    });
  });

  group('Pokemon immutability', () {
    test('types list is not directly mutable via cast', () {
      expect(ditto.types, isA<List<PokemonType>>());
    });

    test('stats list is not directly mutable via cast', () {
      expect(ditto.stats, isA<List<PokemonStat>>());
    });
  });
}
