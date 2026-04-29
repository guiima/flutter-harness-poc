import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../theme/pokemon_type_colors.dart';
import 'pokemon_card_artwork.dart';
import 'pokemon_card_attacks.dart';
import 'pokemon_card_footer.dart';
import 'pokemon_card_header.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final colors = gradientForType(pokemon.primaryType);
    final weaknessType = _weaknessFor(pokemon.primaryType);

    return Center(
      child: AspectRatio(
        aspectRatio: 63 / 88,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: colors,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white38, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              PokemonCardHeader(
                name: pokemon.name,
                hp: pokemon.hp,
                type: pokemon.primaryType,
              ),
              PokemonCardArtwork(
                imageUrl: pokemon.officialArtworkUrl,
                name: pokemon.name,
              ),
              const SizedBox(height: 8),
              PokemonCardAttacks(
                moveNames: pokemon.moves.map((m) => m.name).toList(),
              ),
              const Spacer(),
              PokemonCardFooter(
                pokemonId: pokemon.id,
                weaknessType: weaknessType,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _weaknessFor(String type) {
    const weaknesses = {
      'normal': 'fighting',
      'fire': 'water',
      'water': 'electric',
      'grass': 'fire',
      'electric': 'ground',
      'ice': 'fire',
      'fighting': 'psychic',
      'poison': 'ground',
      'ground': 'water',
      'flying': 'electric',
      'psychic': 'dark',
      'bug': 'fire',
      'rock': 'water',
      'ghost': 'ghost',
      'dragon': 'ice',
      'dark': 'fighting',
      'steel': 'fire',
      'fairy': 'steel',
    };
    return weaknesses[type.toLowerCase()] ?? 'fighting';
  }
}
