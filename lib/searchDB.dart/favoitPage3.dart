import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/searchDB.dart/DbFavorite.dart';

class FavoritePage32 extends StatefulWidget {
  const FavoritePage32({Key? key}) : super(key: key);

  @override
  _FavoritePage32State createState() => _FavoritePage32State();
}

class _FavoritePage32State extends State<FavoritePage32> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    List<String> loadedFavorites = await PreferencesHelper.getFavorites();
    setState(() {
      favorites = loadedFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index]),
          );
        },
      ),
    );
  }
}
