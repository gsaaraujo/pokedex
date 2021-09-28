import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/repositories/pokemon_repository/pokemon_repository.dart';
import 'package:pokedex/app/services/auth_services.dart';

class HomeController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn google = GoogleSignIn();
  final pokemonUrlCollection = 'https://pokeapi.co/api/v2/pokemon?limit=30';

  List<PokemonModel>? pokemonCollection;
  late Future<List<PokemonModel>> pokemonCollectionCopy;
  bool isAuthFailed = false;
  bool isLoading = false;
  String textField = '';
  Timer? timer;

  handleTextField(String text) {
    List<PokemonModel>? copy = pokemonCollection;
    textField = text;

    RegExp regex = RegExp(textField, caseSensitive: false);

    copy = copy!.where((element) => regex.hasMatch(element.name)).toList();

    pokemonCollectionCopy = Future.value(copy);
    notifyListeners();
  }

  Future<List<PokemonModel>?> getPokemonCollection() async {
    try {
      var result =
          await PokemonRepository(pokemonUrlCollection).getPokemonCollection();

      pokemonCollection = result;
      return result;
    } catch (e) {
      return Future.error('Error: $e');
    }
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
