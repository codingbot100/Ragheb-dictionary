import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/HomePage/searchPage/searchPage.dart';

class FavoritesPage extends StatelessWidget {
  final List<CardItem> favorites;
  FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favoriteitem = favorites[index];
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

class InfoPage extends StatefulWidget {
  final CardItem info;

  const InfoPage({Key? key, required this.info}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: ListTile(
        title: Text(widget.info.description),
      ),
    );
  }
}
