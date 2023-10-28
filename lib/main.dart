import 'package:flutter/material.dart';
import 'package:pokemon_app/model/Pokemon.dart';
import 'package:pokemon_app/screens/home.dart';
import 'package:pokemon_app/screens/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        Home.routeName: (context) => const Home(),
        CardPokemon.routeName: (context) {
          final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
          return CardPokemon(
            pokemonName: pokemon,
          );
        },
      },
    );
  }
}
