import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/components/pokemon_favorite.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/utils/pokemon_type_colors.dart';

class FavoritesItem extends StatelessWidget {
  FavoritesItem({Key? key, required this.pokemon}) : super(key: key);

  Map<String, dynamic>? pokemon;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [];

    for (var each in pokemon!['types']) {
      for (var type in PokemonTypeColors.type) {
        if (each['type']['name'] == type['type']) {
          colors.add(type['color']);
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 92,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colors[0], colors.length == 2 ? colors[1] : colors[0]])),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            child: SvgPicture.network(
              pokemon!['sprites'],
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 15),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon!['name'].toString()[0].toUpperCase() +
                      pokemon!['name'].substring(1).toLowerCase(),
                  style: AppTextStyles.pokemonCollectionTitle,
                ),
                Row(
                  children: [
                    ...pokemon!['types']
                        .map<Widget>((type) => Text(
                              type['type']['name'].toString()[0].toUpperCase() +
                                  type['type']['name']
                                      .substring(1)
                                      .toLowerCase() +
                                  ' ',
                              style: AppTextStyles.pokemonCollectionSubtitle,
                              textAlign: TextAlign.start,
                            ))
                        .toList(),
                    // PokemonFavorite(pokemon: pokemon)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
