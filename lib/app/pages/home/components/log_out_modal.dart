import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/pages/home/home_controller.dart';

class LogOutModal extends StatelessWidget {
  const LogOutModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<HomeController>();

    return Container(
      height: 348,
      color: AppColors.background,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(AppAssetsPath.lineSvg),
            const SizedBox(height: 90),
            Text(
              'Would you like to\nleave?',
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 44),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (_controller.isLoading == false) {
                      await _controller.signOut();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.buttonBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: AppTextStyles.heading,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1.5, color: AppColors.buttonBorder),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'No',
                        style: AppTextStyles.heading,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
