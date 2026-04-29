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
    testWidgets('displays name, hp, and type', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardHeader(name: 'ditto', hp: 48, type: 'normal'),
          ),
        ),
      );

      expect(find.text('DITTO'), findsOneWidget);
      expect(find.text('HP 48'), findsOneWidget);
      expect(find.text('NORMAL'), findsOneWidget);
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
    testWidgets('displays pokemon number and weakness', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokemonCardFooter(pokemonId: 132, weaknessType: 'fighting'),
          ),
        ),
      );

      expect(find.text('No.132'), findsOneWidget);
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

      expect(find.text('No.001'), findsOneWidget);
    });
  });

  group('PokemonCard', () {
    testWidgets('renders without crashing with Ditto data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PokemonCard(pokemon: _ditto()))),
      );

      expect(find.byType(PokemonCard), findsOneWidget);
      expect(find.text('DITTO'), findsOneWidget);
      expect(find.text('HP 48'), findsOneWidget);
    });

    testWidgets('shows normal type weakness for normal type pokemon',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: PokemonCard(pokemon: _ditto()))),
      );

      expect(find.textContaining('FIGHTING'), findsOneWidget);
    });
  });
}
