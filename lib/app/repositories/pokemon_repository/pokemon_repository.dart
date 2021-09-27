import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/repositories/pokemon_repository/pokemon_repository_interface.dart';

class PokemonRepository implements IPokemonRepositoryInterface {
  PokemonRepository(this.pokemonUriCollection);

  final String pokemonUriCollection;

  @override
  Future<List<PokemonModel>?> getPokemonCollection() async {
    final urisResponse = await http.get(Uri.parse(pokemonUriCollection));

    if (urisResponse.statusCode == 200) {
      final Map<String, dynamic> jsonUri = jsonDecode(urisResponse.body);
      final uris = jsonUri['results'].map((each) => each['url']);

      final pokemonCollection = [];

      for (var pokeUri in uris) {
        var response = await http.get(Uri.parse(pokeUri));
        pokemonCollection.add(jsonDecode(response.body));
      }

      pokemonCollection.forEach((each) {
        each['sprites'] =
            each['sprites']['other']['dream_world']['front_default'];
      });

      List<PokemonModel> pokemonCollectionModel =
          pokemonCollection.map((e) => PokemonModel.fromMap(e)).toList();

      return pokemonCollectionModel;
    }
  }
}
