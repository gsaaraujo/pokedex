import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/pages/home/home_controller.dart';
import 'package:pokedex/app/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/app/models/user_model.dart';
import 'package:pokedex/app/services/auth_services.dart';
import 'package:pokedex/app/constants/app_routes_name.dart';
import 'package:pokedex/app/pages/login/login_controller.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
            value: AuthServices(_auth, _google).authStateChanges(),
            initialData: null),
        ChangeNotifierProvider<LoginController>(
          create: (_) => LoginController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        color: AppColors.background,
      ),
    );
  }
}
