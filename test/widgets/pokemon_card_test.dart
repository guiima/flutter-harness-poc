import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:claude_learning/models/pokemon.dart';
import 'package:claude_learning/models/pokemon_move.dart';
import 'package:claude_learning/models/pokemon_stat.dart';
import 'package:claude_learning/models/pokemon_type.dart';
import 'package:claude_learning/widgets/pokemon_card.dart';
import 'package:claude_learning/widgets/pokemon_card_attacks.dart';
import 'package:claude_learning/widgets/pokemon_card_footer.dart';
import 'package:claude_learning/widgets/pokemon_card_header.dart';

const _normalColors = [Color(0xFFD2D0CF), Color(0xFFA8A870)];

Pokemon _ditto() => const Pokemon(
      id: 132,
      name: 'ditto',
      height: 3,
      weight: 40,
      spriteUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
      officialArtworkUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png',
      types: [PokemonType(name: 'normal')],
      stats: [
        PokemonStat(name: 'hp', baseStat: 48),
        PokemonStat(name: 'attack', baseStat: 48),
      ],
      moves: [PokemonMove(name: 'transform')],
    );

void main() {
  group('PokemonCardHeader', () {
    testWidgets('displays name in title case, hp, and type initial', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardHeader(
              name: 'ditto',
              hp: 48,
              type: 'normal',
              colors: _normalColors,
            ),
          ),
        ),
      );

      expect(find.text('Ditto'), findsOneWidget);
      expect(find.text('PS 48'), findsOneWidget);
      expect(find.text('N'), findsOneWidget); // type initial
    });

    testWidgets('displays BÁSICO stage badge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardHeader(
              name: 'ditto',
              hp: 48,
              type: 'normal',
              colors: _normalColors,
            ),
          ),
        ),
      );

      expect(find.text('BÁSICO'), findsOneWidget);
    });
  });

  group('PokemonCardAttacks', () {
    testWidgets('renders up to 2 moves', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardAttacks(
              moveNames: ['transform', 'tackle', 'ignored-move'],
            ),
          ),
        ),
      );

      expect(find.text('TRANSFORM'), findsOneWidget);
      expect(find.text('TACKLE'), findsOneWidget);
      expect(find.text('IGNORED MOVE'), findsNothing);
    });

    testWidgets('renders single move when list has one entry', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardAttacks(moveNames: ['transform']),
          ),
        ),
      );

      expect(find.text('TRANSFORM'), findsOneWidget);
    });
  });

  group('PokemonCardFooter', () {
    testWidgets('displays formatted pokemon number and weakness', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardFooter(pokemonId: 132, weaknessType: 'fighting'),
          ),
        ),
      );

      expect(find.text('132/???'), findsOneWidget);
      expect(find.textContaining('FIGHTING'), findsOneWidget);
    });

    testWidgets('pads id to 3 digits', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardFooter(pokemonId: 1, weaknessType: 'fire'),
          ),
        ),
      );

      expect(find.text('001/???'), findsOneWidget);
    });

    testWidgets('shows Resistência and Recuo labels', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardFooter(pokemonId: 132, weaknessType: 'fighting'),
          ),
        ),
      );

      expect(find.text('Resistência'), findsOneWidget);
      expect(find.text('Recuo'), findsOneWidget);
    });
  });

  group('PokemonCard', () {
    testWidgets('renders without crashing with Ditto data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PokemonCard(pokemon: _ditto()))),
      );

      expect(find.byType(PokemonCard), findsOneWidget);
      expect(find.text('Ditto'), findsOneWidget);
      expect(find.text('PS 48'), findsOneWidget);
    });

    testWidgets('shows info bar with height and weight', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PokemonCard(pokemon: _ditto()))),
      );

      expect(find.textContaining('0.3m'), findsOneWidget);
      expect(find.textContaining('4.0kg'), findsOneWidget);
    });

    testWidgets('shows normal type weakness for normal type pokemon', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PokemonCard(pokemon: _ditto()))),
      );

      expect(find.textContaining('FIGHTING'), findsOneWidget);
    });
  });
}
