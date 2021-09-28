import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/repositories/pokemon_favorite_repository/pokemon_favorite_repository.dart';

class PokemonFavorite extends StatefulWidget {
  const PokemonFavorite({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
          _controller.addFavorite();
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.backgroundOpacity,
          borderRadius: BorderRadius.circular(25),
        ),
        child: isFavorite == false
            ? const Icon(
                Icons.favorite_border_outlined,
                color: AppColors.heartIconBorder,
                size: 28,
              )
            : const Icon(
                Icons.favorite_outlined,
                color: AppColors.heartIconFilled,
                size: 28,
              ),
      ),
    );
  }
}
