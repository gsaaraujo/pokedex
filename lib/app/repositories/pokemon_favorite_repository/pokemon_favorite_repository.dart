import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/app/repositories/pokemon_favorite_repository/pokemon_favorite_repository_interface.dart';

class PokemonFavoriteRepository implements IPokemonFavoriteRepositoryInterface {
  PokemonFavoriteRepository(this.firebaseFirestore, this.firebaseAuth);

  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;

  @override
  Future<void> addFavorite() async {
    try {
      User? currentUser = firebaseAuth.currentUser;

      firebaseFirestore
          .collection('users')
          .doc(currentUser!.uid)
          .set({'data': 'teste'});
    } catch (e) {
      print('deu ruim');
    }
  }
}
