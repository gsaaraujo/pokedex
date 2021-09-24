import 'package:flutter/material.dart';
import 'package:pokedex/app/pages/home/home_page.dart';
import 'package:pokedex/app/pages/login/login_page.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
