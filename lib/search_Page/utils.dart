import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteController extends GetxController {
  RxSet<Map<String, String>> favorites = <Map<String, String>>{}.obs;

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesList = prefs.getStringList('favorites');

    if (favoritesList != null) {
      favorites.value = favoritesList
          .map((favoriteString) => Map<String, String>.from(jsonDecode(favoriteString)))
          .toSet();
    }
  }

  Future<void> saveFavorite(Map<String, String> favorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

    final String uniqueId = '${favorite['description']}-${favorite['footnote']}';

    favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == uniqueId);

    favoritesSet.add(jsonEncode({
      ...favorite,
      'id': uniqueId,
    }));
    prefs.setStringList('favorites', favoritesSet.toList());
    loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

    favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == id);
    prefs.setStringList('favorites', favoritesSet.toList());
    loadFavorites();
  }
}
