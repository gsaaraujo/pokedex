import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex/app/services/auth_services.dart';

class HomeController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn google = GoogleSignIn();
  final pokemonUrlCollection = 'https://pokeapi.co/api/v2/pokemon?limit=20';
  bool isAuthFailed = false;
  bool isLoading = false;

  Future<List<PokemonModel>?> getPokemonCollection() async {
    return await PokemonRepository(pokemonUrlCollection).getPokemonCollection();
  }

  Future<void> signOut() async {
    try {
      isLoading = true;
      notifyListeners();

      await AuthServices(auth, google).signOut();
    } catch (e) {
      isAuthFailed = true;
    } finally {
      isLoading = false;
      isAuthFailed = false;
      notifyListeners();
    }
  }
}
