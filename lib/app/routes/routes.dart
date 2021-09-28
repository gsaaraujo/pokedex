import 'package:flutter/material.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/models/user_model.dart';
import 'package:pokedex/app/pages/bottom_navigation/bottom_navigation_page.dart';
import 'package:pokedex/app/pages/pokemon_details/pokemon_details_page.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/app/pages/home/home_page.dart';
import 'package:pokedex/app/pages/login/login_page.dart';
import 'package:pokedex/app/constants/app_routes_name.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(settings) {
    switch (settings.name) {
      case AppRoutesName.wrapper:
        return MaterialPageRoute(builder: (_) => const WrapperWidget());
      case AppRoutesName.pokemonDetailsPage:
        var data = settings.arguments as PokemonModel;
        return MaterialPageRoute(
            builder: (_) => PokemonDetailsPage(pokemon: data));
      default:
        return MaterialPageRoute(builder: (_) => const WrapperWidget());
    }
  }
}

class WrapperWidget extends StatelessWidget {
  const WrapperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();

    if (user == null) {
      return const LoginPage();
    } else {
      return const BottomNavigationPage();
    }
  }
}
