import 'package:flutter/material.dart';

class PokemonCardFooter extends StatelessWidget {
  final int pokemonId;
  final String weaknessType;

  const PokemonCardFooter({
    super.key,
    required this.pokemonId,
    required this.weaknessType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Weakness: ${weaknessType.toUpperCase()} ×2',
            style: const TextStyle(fontSize: 10, color: Colors.white70),
          ),
          Text(
            'No.${pokemonId.toString().padLeft(3, '0')}',
            style: const TextStyle(fontSize: 10, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
