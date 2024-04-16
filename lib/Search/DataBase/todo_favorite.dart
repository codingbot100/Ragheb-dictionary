import 'package:hive_flutter/hive_flutter.dart';

class ToDo_favorite {
  List favorite = [];

  var _meBox = Hive.box('mybox');

  void createInitialData() {
    favorite = [];
  }

  void loadData() {
    favorite = _meBox.get("TODOLIST") ?? [];
  }

  void updateDataBase() {
    _meBox.put('TODOLIST', favorite);
  }

  void updateImageState(String name, String newImage) {
    for (var item in favorite) {
      if (item['name'] == name) {
        item['image'] = newImage;
        updateDataBase(); // Call updateDataBase to persist changes
        break;
      }
    }
  }
}
