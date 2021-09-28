import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/app/models/pokemon_model.dart';
import 'package:pokedex/app/pages/home/components/pokemon_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/app/models/user_model.dart';
import 'package:pokedex/app/constants/app_colors.dart';
import 'package:pokedex/app/constants/app_text_styles.dart';
import 'package:pokedex/app/constants/app_assets_path.dart';
import 'package:pokedex/app/pages/home/home_controller.dart';
import 'package:pokedex/app/pages/home/components/log_out_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<PokemonModel>?>? _pokemonCollection;

  @override
  void initState() {
    super.initState();

    final _controller = context.read<HomeController>();
    _pokemonCollection = _controller.getPokemonCollection();

    _controller.addListener(() {
      if (_controller.isAuthFailed) {
        const snackBar = SnackBar(content: Text('Something went wrong.'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _controller = context.watch<HomeController>();
    final _user = context.watch<UserModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            Container(
              height: size.height * 0.19,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: AppColors.header),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0),
                                    ),
                                  ),
                                  builder: (context) {
                                    return const LogOutModal();
                                  });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: _user.photoURL == null
                                  ? Image.asset(
                                      AppAssetsPath.defaultUserPhotoJpg,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      _user.photoURL!,
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Hi, ${_user.name}',
                            style: AppTextStyles.headerHeading,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SvgPicture.asset(AppAssetsPath.pikachuSvg),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 27),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (text) {
                  _controller.handleTextField(text);
                },
                maxLength: 20,
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Search pokémon",
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppAssetsPath.searchSvg),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 31),
            Expanded(
              child: FutureBuilder<List<PokemonModel>?>(
                  future: _controller.textField == ''
                      ? _pokemonCollection
                      : _controller.pokemonCollectionCopy,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonBorder,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.7375),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return PokemonItem(
                                  pokemon: snapshot.data![index]);
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Something went wrong',
                              style: AppTextStyles.heading),
                        );
                      }
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonBorder,
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
