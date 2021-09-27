import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/components/pokemon_item_title.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/pages/pokemon_details/components/base_stats.dart';
import 'package:pokedex/app/pages/pokemon_details/components/characteristic.dart';
import 'package:pokedex/app/utils/pokemon_type_colors.dart';
import 'package:pokedex/main.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({Key? key, required this.pokemon}) : super(key: key);

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.445,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors[0],
                    colors.length == 2 ? colors[1] : colors[0]
                  ]),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: size.height * 0.146),
                    PokemonItemTitle(title: pokemon.name, fontSize: 24),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon.types
                          .map(
                            (type) => PokemonItemTitle(
                              title: type['type']['name'],
                              fontSize: 18,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                    )),
                Positioned(
                  left: -40,
                  bottom: 0,
                  child: SizedBox(
                    width: size.width * 0.386,
                    height: size.height * 0.178,
                    child: Image.asset(
                      AppAssetsPath.pokeballPng,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.06,
                  left: 88,
                  child: SizedBox(
                    width: size.width * 0.077,
                    height: size.height * 0.022,
                    child: Image.asset(
                      AppAssetsPath.bubblesPng,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.193,
                  left: 24,
                  child: SizedBox(
                    width: size.width * 0.077,
                    height: size.height * 0.022,
                    child: Image.asset(
                      AppAssetsPath.bubblesPng,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.16,
                  right: 26,
                  child: SizedBox(
                    width: size.width * 0.077,
                    height: size.height * 0.022,
                    child: Image.asset(
                      AppAssetsPath.bubblesPng,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  right: -40,
                  bottom: 0,
                  child: SizedBox(
                    width: size.width * 0.386,
                    height: size.height * 0.178,
                    child: Image.asset(
                      AppAssetsPath.pokeballPng,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: size.width * 0.28,
                  child: Hero(
                    tag: pokemon.sprites,
                    child: SizedBox(
                      width: size.width * 0.427,
                      height: size.height * 0.19,
                      child: SvgPicture.network(
                        pokemon.sprites,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 43),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Characteristics',
                    style: AppTextStyles.pokemonStatsTitle,
                  ),
                  const SizedBox(height: 20),
                  Characteristic(
                    title: 'Height',
                    stat: pokemon.height,
                    subtitle: 'decimeters',
                  ),
                  const SizedBox(height: 10),
                  Characteristic(
                    title: 'Weight',
                    stat: pokemon.weight,
                    subtitle: 'hectograms',
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Base Stats',
                    style: AppTextStyles.pokemonStatsTitle,
                  ),
                  const SizedBox(height: 20),
                  BaseStats(
                    title: 'HP',
                    stat: pokemon.stats[0]['base_stat'],
                  ),
                  const SizedBox(height: 10),
                  BaseStats(
                    title: 'Attack',
                    stat: pokemon.stats[1]['base_stat'],
                  ),
                  const SizedBox(height: 10),
                  BaseStats(
                    title: 'Defense',
                    stat: pokemon.stats[2]['base_stat'],
                  ),
                  const SizedBox(height: 10),
                  BaseStats(
                    title: 'Special-atk',
                    stat: pokemon.stats[3]['base_stat'],
                  ),
                  const SizedBox(height: 10),
                  BaseStats(
                    title: 'Special-def',
                    stat: pokemon.stats[4]['base_stat'],
                  ),
                  const SizedBox(height: 10),
                  BaseStats(
                    title: 'Speed',
                    stat: pokemon.stats[5]['base_stat'],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
