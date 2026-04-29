class PokemonStat {
  final String name;
  final int baseStat;

  const PokemonStat({required this.name, required this.baseStat});

  factory PokemonStat.fromJson(Map<String, dynamic> json) => PokemonStat(
        name: json['stat']['name'] as String,
        baseStat: json['base_stat'] as int,
      );
}
