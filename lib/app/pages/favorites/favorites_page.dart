import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/pages/favorites/components/favorites_item.dart';
import 'package:pokedex/app/pages/favorites/favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<List<PokemonModel>>? _pokemonFavorite;

  @override
  void initState() {
    super.initState();

    final _controller = FavoritesController();
    _pokemonFavorite = _controller.getFavoritePokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Your favorites',
              style: AppTextStyles.heading,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: FutureBuilder<List<PokemonModel>>(
              future: _pokemonFavorite,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FavoritesItem(pokemon: snapshot.data![index]);
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went wrong',
                          style: AppTextStyles.heading),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonBorder,
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonBorder,
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
