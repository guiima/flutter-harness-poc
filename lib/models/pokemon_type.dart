class PokemonType {
  final String name;

  const PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      PokemonType(name: json['type']['name'] as String);
}
