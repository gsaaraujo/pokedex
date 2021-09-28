import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/components/pokemon_favorite.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_routes_name.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/components/pokemon_item_title.dart';
import 'package:pokedex/app/utils/pokemon_type_colors.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Color> colors = [];

    for (var each in pokemon.types) {
      for (var type in PokemonTypeColors.type) {
        if (each['type']['name'] == type['type']) {
          colors.add(type['color']);
        }
      }
    }

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutesName.pokemonDetailsPage, arguments: pokemon);
      },
      child: Stack(
        children: [
          Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: size.height * 0.24,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors[0],
                      colors.length == 2 ? colors[1] : colors[0]
                    ]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonItemTitle(title: pokemon.name, fontSize: 20),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pokemon.types
                            .map(
                              (type) => PokemonItemTitle(
                                  title: type['type']['name'], fontSize: 16),
                            )
                            .toList(),
                      ),
                      PokemonFavorite(
                        pokemon: pokemon,
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
            child: Hero(
              tag: pokemon.sprites,
              child: SizedBox(
                width: size.width * 0.32,
                height: size.height * 0.14,
                child: SvgPicture.network(
                  pokemon.sprites,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
