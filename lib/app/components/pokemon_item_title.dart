import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';

enum Type { pokeName, pokeType }

class PokemonItemTitle extends StatelessWidget {
  const PokemonItemTitle(
      {Key? key, required this.title, required this.fontSize})
      : super(key: key);

  final String title;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.backgroundOpacity,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title[0].toUpperCase() + title.substring(1).toLowerCase(),
            style: AppTextStyles.pokemonCollectionTitle.merge(
              TextStyle(fontSize: fontSize),
            )),
      ),
    );
  }
}
