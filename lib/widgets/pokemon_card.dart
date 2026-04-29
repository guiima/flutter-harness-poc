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
    final typeColor = colors.first;
    final weaknessType = _weaknessFor(pokemon.primaryType);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: AspectRatio(
          aspectRatio: 63 / 88,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F2E2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: typeColor, width: 4),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PokemonCardHeader(
                  name: pokemon.name,
                  hp: pokemon.hp,
                  type: pokemon.primaryType,
                  colors: colors,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: PokemonCardArtwork(
                    imageUrl: pokemon.officialArtworkUrl,
                    name: pokemon.name,
                    typeColor: typeColor,
                  ),
                ),
                _InfoBar(pokemon: pokemon),
                const Divider(height: 1, color: Color(0xFFCCBBAA)),
                Expanded(
                  child: PokemonCardAttacks(
                    moveNames: pokemon.moves.map((m) => m.name).toList(),
                  ),
                ),
                PokemonCardFooter(
                  pokemonId: pokemon.id,
                  weaknessType: weaknessType,
                ),
              ],
            ),
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

class _InfoBar extends StatelessWidget {
  final Pokemon pokemon;

  const _InfoBar({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final heightM = (pokemon.height / 10).toStringAsFixed(1);
    final weightKg = (pokemon.weight / 10).toStringAsFixed(1);
    final id = pokemon.id.toString().padLeft(4, '0');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Text(
        'Nº$id · Altura: ${heightM}m · Peso: ${weightKg}kg',
        style: const TextStyle(fontSize: 8, color: Color(0xFF888888)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
