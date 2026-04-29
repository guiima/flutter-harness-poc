import 'package:flutter/material.dart';

class PokemonCardHeader extends StatelessWidget {
  final String name;
  final int hp;
  final String type;
  final List<Color> colors;

  const PokemonCardHeader({
    super.key,
    required this.name,
    required this.hp,
    required this.type,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        name.isNotEmpty ? name[0].toUpperCase() + name.substring(1) : name;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'BÁSICO',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              displayName,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 3, color: Colors.black38)],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'PS $hp',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 2, color: Colors.black38)],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                type.isNotEmpty ? type[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
