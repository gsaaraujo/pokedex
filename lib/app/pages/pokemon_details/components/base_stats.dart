import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';

class BaseStats extends StatelessWidget {
  const BaseStats({Key? key, required this.title, required this.stat})
      : super(key: key);

  final String title;
  final int stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: AppTextStyles.pokemonStatsSubtitle100,
          ),
        ),
        Text(
          '$stat ',
          style: AppTextStyles.pokemonStatsSubtitle50,
        ),
        Container(
          height: 2,
          width: (stat * 1.0),
          color: AppColors.baseStatsLineType2,
        ),
      ],
    );
  }
}
