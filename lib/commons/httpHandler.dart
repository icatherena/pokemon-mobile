import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pokemon_app/model/Pokemon.dart';
import 'package:pokemon_app/model/PokemonDetail.dart';

class HttpHandler {
  Future<List<Pokemon>> getPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pokemon> allPokemons = [];
      for (var pokemon in data['results']) {
        allPokemons.add(Pokemon(id: pokemon['id'] ?? 0, name: pokemon['name']));
      }
      return allPokemons;
    } else {
      throw Exception('Failed to load pokemons');
    }
  }

  Future<PokemonDetail> getPokemon(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PokemonDetail.fromJson(data);
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
}
