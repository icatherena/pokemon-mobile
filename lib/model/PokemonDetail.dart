import 'package:pokemon_app/model/PokemonType.dart';

class PokemonDetail {
  final int id;
  final String name;
  final String height;
  final String weight;
  final String image;
  final List<PokemonType> types;

  PokemonDetail(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.image,
      required this.types});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    /* return PokemonDetail(
      id: json['id'],
      name: json['name'],
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      image: json['image'].toString(),
    ); */
    final int id = json['id'];
    final String name = json['name'];
    final String height = json['height'].toString();
    final String weight = json['weight'].toString();
    final String image =
        json['sprites']['other']['official-artwork']['front_default'];
    final List<PokemonType> types = (json['types'] as List)
        .map((type) => PokemonType.fromJson(type['type']))
        .toList();

    return PokemonDetail(
      id: id,
      name: name,
      height: height,
      weight: weight,
      image: image,
      types: types,
    );
  }
}
