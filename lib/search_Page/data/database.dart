import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase3 {
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

class ToDodatabaseTime {
  List dateAndTime = [];

  final _meBox = Hive.box('mybox');

  void createInitialData() {
    dateAndTime = [];
  }

  void loadData() {
    dateAndTime = _meBox.get("TODODateAndTime") ?? [];
  }

  void updateDataBase() {
    _meBox.put('TODODateAndTime', dateAndTime);
  }
}

