import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String favoriteKey = 'favorites';

  static Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoriteKey) ?? [];
  }

  static Future<void> addFavorite(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.add(item);
    await prefs.setStringList(favoriteKey, favorites);
  }

  static Future<void> removeFavorite(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = await getFavorites();
    favorites.remove(item);
    await prefs.setStringList(favoriteKey, favorites);
  }
}
