import 'pokemon_move.dart';
import 'pokemon_stat.dart';
import 'pokemon_type.dart';

class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String spriteUrl;
  final String officialArtworkUrl;
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  final List<PokemonMove> moves;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.spriteUrl,
    required this.officialArtworkUrl,
    required this.types,
    required this.stats,
    required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    final other = sprites['other'] as Map<String, dynamic>;
    final artwork = other['official-artwork'] as Map<String, dynamic>;

    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      spriteUrl: sprites['front_default'] as String,
      officialArtworkUrl: artwork['front_default'] as String,
      types: (json['types'] as List<dynamic>)
          .map((t) => PokemonType.fromJson(t as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List<dynamic>)
          .map((s) => PokemonStat.fromJson(s as Map<String, dynamic>))
          .toList(),
      moves: (json['moves'] as List<dynamic>)
          .map((m) => PokemonMove.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  String get primaryType => types.isNotEmpty ? types.first.name : 'normal';

  int get hp =>
      stats
          .where((s) => s.name == 'hp')
          .map((s) => s.baseStat)
          .firstOrNull ??
      0;
}
