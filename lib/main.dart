import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/pokemon_service.dart';
import 'services/real_http_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(
        service: PokemonService(RealHttpClient()),
      ),
    );
  }
}
