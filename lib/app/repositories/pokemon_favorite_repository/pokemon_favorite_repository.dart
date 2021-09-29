import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/repositories/pokemon_favorite_repository/pokemon_favorite_repository_interface.dart';

class PokemonFavoriteRepository implements IPokemonFavoriteRepositoryInterface {
  PokemonFavoriteRepository(this.firebaseFirestore, this.firebaseAuth);

  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;
  List<String>? favoriteName;

  @override
  Future<void> addFavorite(PokemonModel pokemon, bool isFavorite) async {
    try {
      User? currentUser = firebaseAuth.currentUser;

      var items = firebaseFirestore.collection('users').doc(currentUser!.uid);

      if (isFavorite) {
        items.update({
          'favorites': FieldValue.arrayUnion([
            {
              'id': pokemon.id,
              'name': pokemon.name,
              'types': pokemon.types,
              'height': pokemon.height,
              'weight': pokemon.weight,
              'stats': pokemon.stats,
              'sprites': pokemon.sprites
            }
          ])
        });
      } else {
        items.update({
          'favorites': FieldValue.arrayRemove([
            {
              'id': pokemon.id,
              'name': pokemon.name,
              'types': pokemon.types,
              'height': pokemon.height,
              'weight': pokemon.weight,
              'stats': pokemon.stats,
              'sprites': pokemon.sprites
            }
          ])
        });
      }
    } catch (e) {
      Future.error('Error $e');
    }
  }

  @override
  Future<List<PokemonModel>> getFavoritePokemon() async {
    User? currentUser = firebaseAuth.currentUser;
    List<PokemonModel>? pokemonList = [];

    var reference = firebaseFirestore.collection('users').doc(currentUser!.uid);
    var pokemonCollection = await reference.get();

    pokemonCollection.data()!.forEach((key, value) {
      value.forEach((each) => pokemonList.add(PokemonModel.fromMap(each)));
    });

    return pokemonList;
  }
}
