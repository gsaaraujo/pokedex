import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/repositories/pokemon_favorite_repository/pokemon_favorite_repository.dart';

class PokemonFavorite extends StatefulWidget {
  const PokemonFavorite({Key? key, required this.pokemon}) : super(key: key);

  final PokemonModel pokemon;

  @override
  _PokemonFavoriteState createState() => _PokemonFavoriteState();
}

class _PokemonFavoriteState extends State<PokemonFavorite> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late PokemonFavoriteRepository _controller;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    _controller = PokemonFavoriteRepository(_firebaseFirestore, _firebaseAuth);

    _controller.getFavoritePokemon().then((value) {
      setState(() {
        for (var each in value) {
          if (each.name == widget.pokemon.name) {
            isFavorite = true;
            break;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
          _controller.addFavorite(widget.pokemon, isFavorite);
        });
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.backgroundOpacity,
          borderRadius: BorderRadius.circular(28),
        ),
        child: isFavorite == false
            ? const Icon(
                Icons.favorite_border_outlined,
                color: AppColors.heartIconBorder,
                size: 30,
              )
            : const Icon(
                Icons.favorite_outlined,
                color: AppColors.heartIconFilled,
                size: 30,
              ),
      ),
    );
  }
}
