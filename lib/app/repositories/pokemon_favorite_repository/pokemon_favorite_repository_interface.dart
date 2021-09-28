import 'package:pokedex/app/models/pokemon_model.dart';

abstract class IPokemonFavoriteRepositoryInterface {
  Future<void> addFavorite(PokemonModel pokemon, bool isFavorite);
}
