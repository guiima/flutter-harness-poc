import 'package:flutter/material.dart';

class PokemonCardAttacks extends StatelessWidget {
  final List<String> moveNames;

  const PokemonCardAttacks({super.key, required this.moveNames});

  @override
  Widget build(BuildContext context) {
    final displayed = moveNames.take(2).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (index, name) in displayed.indexed)
            _AttackRow(name: name, damage: (index + 1) * 40),
        ],
      ),
    );
  }
}

class _AttackRow extends StatelessWidget {
  final String name;
  final int damage;

  const _AttackRow({required this.name, required this.damage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.bolt, size: 14, color: Colors.amber),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              name.replaceAll('-', ' ').toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '$damage',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
