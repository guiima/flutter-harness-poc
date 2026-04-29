import 'package:flutter/material.dart';

class PokemonCardAttacks extends StatelessWidget {
  final List<String> moveNames;

  const PokemonCardAttacks({super.key, required this.moveNames});

  @override
  Widget build(BuildContext context) {
    final displayed = moveNames.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, name) in displayed.indexed) ...[
          if (index > 0)
            const Divider(height: 1, color: Color(0xFFDDCCAA), indent: 10, endIndent: 10),
          _AttackRow(name: name, damage: (index + 1) * 40),
        ],
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC107),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt, size: 12, color: Colors.white),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  name.replaceAll('-', ' ').toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Text(
                '$damage',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
