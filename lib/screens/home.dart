import 'package:flutter/material.dart';
import 'package:pokemon_app/commons/httpHandler.dart';
import 'package:pokemon_app/model/Pokemon.dart';
import 'package:pokemon_app/screens/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const routeName = '/';

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<Pokemon> allPokemons = [];
  HttpHandler httpHandler = HttpHandler();

  @override
  void initState() {
    super.initState();
    httpHandler.getPokemons().then((result) {
      setState(() {
        allPokemons = result;
      });
    });
  }

  String capitalize(String s) => '${s[0].toUpperCase()}${s.substring(1)}';

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: ListView.builder(
            itemCount: allPokemons.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pokemon',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                          ),
                          Text(
                            capitalize(allPokemons[index].name),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      trailing: TextButton(
                        child: const Text('See More'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardPokemon(
                                  pokemonName: Pokemon(
                                id: allPokemons[index].id,
                                name: allPokemons[index].name,
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _filterAllPokemons,
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<void> _filterAllPokemons() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Which pokemon are you looking for?"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Pokemon',
                    hintText: 'Type its name',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Look for it!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
