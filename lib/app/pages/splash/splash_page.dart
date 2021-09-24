import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/constants/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: Image.asset(
          AppAssetsPath.logoPng,
          width: 130,
          height: 125.3,
        ),
      ),
    );
  }
}
