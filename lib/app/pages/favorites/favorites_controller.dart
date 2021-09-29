import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/app/repositories/pokemon_favorite_repository/pokemon_favorite_repository.dart';

class FavoritesController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getFavoritePokemon() async {
    var favorites =
        PokemonFavoriteRepository(_firestore, _auth).getFavoritePokemon();

    return favorites;
  }
}
