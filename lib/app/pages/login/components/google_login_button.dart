import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';

class GoogleLoginButton extends StatefulWidget {
  GoogleLoginButton(
      {Key? key, required this.handleOnTap, required this.isLoading})
      : super(key: key);

  bool isLoading = false;
  final VoidCallback handleOnTap;

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          widget.handleOnTap();
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.buttonBorder),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppColors.buttonBorder),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                  child: SvgPicture.asset(AppAssetsPath.googleSvg),
                ),
              ),
              Expanded(
                child: Text(
                  'Connect with Google',
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
