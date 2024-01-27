import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/HomePage/searchPage/searchPage.dart';

class FavoritesPage2 extends StatefulWidget {
  final List<CardItem> favorites;
  FavoritesPage2({required this.favorites});

  @override
  State<FavoritesPage2> createState() => _FavoritesPage2State();
}

class _FavoritesPage2State extends State<FavoritesPage2> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final favoriteitem = widget.favorites[index];
          return ListTile(
            title: Text(favoriteitem.title),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
          );
        });
  }
}

class infopage extends StatefulWidget {
  final CardItem info;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  infopage({
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.info, // Add a comma here
    Key? key,
  }) : super(key: key);

  @override
  State<infopage> createState() => _infopageState();
}

class _infopageState extends State<infopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: ListTile(
        title: Text(widget.info.title),
      ),
    );
  }
}
