import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';

class HomeScreen extends StatefulWidget {
  final PokemonService service;

  const HomeScreen({super.key, required this.service});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'ditto');
  Future<Pokemon>? _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _search('ditto');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String name) {
    final query = name.trim().toLowerCase();
    if (query.isEmpty) return;
    setState(() {
      _pokemonFuture = widget.service.fetchPokemon(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text(
          'Pokédex Card',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF16213E),
        elevation: 0,
      ),
      body: Column(
        children: [
          _SearchBar(controller: _controller, onSearch: _search),
          Expanded(child: _CardArea(future: _pokemonFuture)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  const _SearchBar({required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.search,
        autocorrect: false,
        onSubmitted: onSearch,
        decoration: InputDecoration(
          hintText: 'Buscar Pokémon... (ex: pikachu)',
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: const Color(0xFF16213E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.catching_pokemon, color: Colors.white54),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.white70),
            tooltip: 'Buscar',
            onPressed: () => onSearch(controller.text),
          ),
        ),
      ),
    );
  }
}

class _CardArea extends StatelessWidget {
  final Future<Pokemon>? future;

  const _CardArea({required this.future});

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return const Center(
        child: Text(
          'Digite o nome de um Pokémon para começar',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return FutureBuilder<Pokemon>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: PokemonCard(pokemon: snapshot.data!),
        );
      },
    );
  }
}
