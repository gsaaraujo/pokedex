import 'package:pokedex/app/models/pokemon_model.dart';

abstract class IPokemonRepositoryInterface {
  Future<List<PokemonModel>?> getPokemonCollection();
}
