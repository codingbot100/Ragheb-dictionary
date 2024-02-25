import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase3 {
  List favorite = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    favorite = [];
  }

  void loadData() {
    favorite = _meBox.get("TODOLIST");
  }

  void updateDataBase() {
    _meBox.put('TODOLIST', favorite);
  }

  void addToFavorites(String name, String description, String footnote) {
    if (isFavorite(name, description, footnote)) {
      removeFromFavorites(name, description, footnote);
    } else {
      favorite.add([name, description, footnote]);
      updateDataBase();
    }
  }

  void removeFromFavorites(String name, String description, String footnote) {
    favorite.removeWhere((item) =>
        item[0] == name && item[1] == description && item[2] == footnote);
    updateDataBase();
  }

  bool isFavorite(String name, String description, String footnote) {
    return favorite.any((item) =>
        item[0] == name && item[1] == description && item[2] == footnote);
  }
}
