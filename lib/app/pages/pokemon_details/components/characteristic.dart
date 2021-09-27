import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';

class Characteristic extends StatelessWidget {
  const Characteristic(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.stat})
      : super(key: key);

  final String title;
  final String subtitle;
  final int stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: AppTextStyles.pokemonStatsSubtitle100,
          ),
        ),
        const SizedBox(width: 50),
        Text(
          '$stat ' + subtitle,
          style: AppTextStyles.pokemonStatsSubtitle50,
        )
      ],
    );
  }
}
