import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritePage extends StatelessWidget {
  final RxSet<String> favorites = <String>{}.obs;

  @override
  Widget build(BuildContext context) {
    loadFavorites();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Obx(
        () => favorites.isEmpty
            ? Center(
                child: Text('No favorites yet.'),
              )
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  List<Map<String, String>> favoritesList = favorites
                      .map((fav) => jsonDecode(fav))
                      .cast<Map<String, String>>()
                      .toList();

                  return ListTile(
                    title: Text(favoritesList[index]['name'] ?? ''),
                    subtitle: Text(favoritesList[index]['description'] ?? ''),
                    // Add any other details you want to display
                  );
                },
              ),
      ),
    );
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

    favorites.value = favoritesSet ?? {};
  }
}
