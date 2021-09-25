import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/pages/login/components/google_login_button.dart';
import 'package:pokedex/app/pages/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    final _controller = context.read<LoginController>();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    );

    _controller.addListener(() {
      if (_controller.isAuthFailed) {
        const snackBar = SnackBar(content: Text('Authentication has failed.'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controller = context.read<LoginController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 183),
            Lottie.asset(
              AppAssetsPath.pokeballAnimatedJson,
              width: 140,
              height: 126.25,
              controller: _animationController..forward(),
            ),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Connect to find your favorite ',
                  style: AppTextStyles.headingLoginPage,
                  children: [
                    TextSpan(
                      text: 'pokémon',
                      style: AppTextStyles.headingLoginPage
                          .merge(const TextStyle(color: Color(0xFFFF5462))),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 183),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43),
              child: GoogleLoginButton(
                handleOnTap: () {
                  _controller.isLoading == true
                      ? null
                      : _controller.signInWithGoogle();
                },
                isLoading: _controller.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
