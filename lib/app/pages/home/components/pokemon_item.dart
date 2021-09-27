import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/pages/home/components/pokemon_item_title.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            height: size.height * 0.24,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //s[0].toUpperCase() + s.substring(1).toLowerCase(
                PokemonItemTitle(
                    title: pokemon.name[0].toUpperCase() +
                        pokemon.name.substring(1).toLowerCase(),
                    fontSize: 20),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pokemon.types
                          .map((type) => PokemonItemTitle(
                              title: type['type']['name'], fontSize: 16))
                          .toList(),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundOpacity,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: AppColors.heartIconBorder,
                        iconSize: 28,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: size.width * 0.055,
          child: SizedBox(
            width: size.width * 0.32,
            height: size.height * 0.14,
            child: SvgPicture.network(
              pokemon.sprites,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
