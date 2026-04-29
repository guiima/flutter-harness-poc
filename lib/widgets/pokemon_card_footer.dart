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
        color: Color(0xFFEDE8D5),
        border: Border(top: BorderSide(color: Color(0xFFCCBBAA), width: 1)),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Flexible(
            child: _FooterStat(
              label: 'Fraqueza',
              value: '${weaknessType.toUpperCase()} ×2',
            ),
          ),
          const SizedBox(width: 8),
          const _FooterStat(label: 'Resistência', value: '—'),
          const SizedBox(width: 8),
          const _FooterStat(label: 'Recuo', value: '⬤'),
          const Spacer(),
          Text(
            '${pokemonId.toString().padLeft(3, '0')}/???',
            style: const TextStyle(fontSize: 9, color: Color(0xFF888888)),
          ),
        ],
      ),
    );
  }
}

class _FooterStat extends StatelessWidget {
  final String label;
  final String value;

  const _FooterStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 7, color: Color(0xFF888888)),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
