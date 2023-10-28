import 'package:flutter/material.dart';
import 'package:pokemon_app/commons/httpHandler.dart';
import 'package:pokemon_app/model/Pokemon.dart';
import 'package:pokemon_app/model/PokemonDetail.dart';

class CardPokemon extends StatefulWidget {
  static const routeName = '/card';
  final Pokemon pokemonName;

  const CardPokemon({super.key, required this.pokemonName});

  @override
  _CardPokemon createState() => _CardPokemon();
}

class _CardPokemon extends State<CardPokemon> {
  HttpHandler httpHandler = HttpHandler();
  PokemonDetail? pokemon;

  @override
  void initState() {
    super.initState();
    String pokemonName = widget.pokemonName.name;
    httpHandler.getPokemon(pokemonName).then((result) {
      print(result);
      setState(() {
        pokemon = result;
      });
    });
  }

  String capitalize(String s) => '${s[0].toUpperCase()}${s.substring(1)}';

  String getTypeString(PokemonDetail? pokemon) {
    if (pokemon?.types.isNotEmpty == true) {
      return pokemon?.types.map((type) => type.name).join(', ') ??
          'No types found';
    } else {
      return 'No types found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pokemon Detail"),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image(
                  image: NetworkImage(pokemon!.image),
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      capitalize(
                        pokemon?.name ?? 'Oops, something went wron. No name',
                      ),
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Wrap(
                      // INSTEAD OF LISTVIEW.BUILDER TO SHOW POKEMON TYPES LIST
                      spacing: 8.0,
                      children: List.generate(
                        pokemon?.types.length ?? 0,
                        (index) {
                          final type = pokemon?.types[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 8.0,
                            ),
                            child: Text(
                              type?.name ?? 'Type not found',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      'Weight: ${pokemon?.weight}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      'Height: ${pokemon?.height}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              //Image.network(pokemon!.image)
            ]),
          ),
        ));
  }
}
