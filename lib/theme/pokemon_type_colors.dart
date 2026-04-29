import 'package:flutter/material.dart';

const Map<String, List<Color>> pokemonTypeGradients = {
  'normal': [Color(0xFFD2D0CF), Color(0xFFA8A870)],
  'fire': [Color(0xFFFF9741), Color(0xFFD8223B)],
  'water': [Color(0xFF4FC3F7), Color(0xFF05A8D9)],
  'grass': [Color(0xFF78C850), Color(0xFF19A648)],
  'electric': [Color(0xFFFFF176), Color(0xFFFCD021)],
  'lightning': [Color(0xFFFFF176), Color(0xFFFCD021)],
  'psychic': [Color(0xFFCE93D8), Color(0xFF957DAB)],
  'fighting': [Color(0xFFFFCC80), Color(0xFFB16232)],
  'dark': [Color(0xFF4A4A4A), Color(0xFF2E7077)],
  'darkness': [Color(0xFF4A4A4A), Color(0xFF2E7077)],
  'steel': [Color(0xFFCFD8DC), Color(0xFF9EA1A1)],
  'metal': [Color(0xFFCFD8DC), Color(0xFF9EA1A1)],
  'dragon': [Color(0xFF7E57C2), Color(0xFF5060E1)],
  'ice': [Color(0xFF80DEEA), Color(0xFF00ACC1)],
  'bug': [Color(0xFFA8B820), Color(0xFF6D7815)],
  'rock': [Color(0xFFB8A038), Color(0xFF786824)],
  'ghost': [Color(0xFF705898), Color(0xFF493963)],
  'poison': [Color(0xFFA040A0), Color(0xFF6F286F)],
  'ground': [Color(0xFFE0C068), Color(0xFF927D44)],
  'flying': [Color(0xFFA890F0), Color(0xFF6D5E9C)],
  'fairy': [Color(0xFFEE99AC), Color(0xFFF4BDC9)],
};

List<Color> gradientForType(String type) =>
    pokemonTypeGradients[type.toLowerCase()] ??
    pokemonTypeGradients['normal']!;
