class PokemonMove {
  final String name;

  const PokemonMove({required this.name});

  factory PokemonMove.fromJson(Map<String, dynamic> json) =>
      PokemonMove(name: json['move']['name'] as String);
}
