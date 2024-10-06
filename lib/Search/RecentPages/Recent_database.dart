import 'package:hive_flutter/hive_flutter.dart';

class Recent_Database {
  List Recent_db = [];
  var _meBox = Hive.box('mybox');

  void createInitialData() {
    Recent_db = [];
  }

  void loadData() {
    Recent_db = _meBox.get("RecentDatabase") ?? [];
  }

  void updateDataBase() {
    _meBox.put('RecentDatabase', Recent_db);
    // favorite.assignAll(favorite);
  }

  // void updateImageState(String name, String newImage) {
  //   for (var item in Recent_db) {
  //     if (item['name'] == name) {
  //       item['image'] = newImage;
  //       updateDataBase(); // Call updateDataBase to persist changes
  //       break;
  //     }
  //   }
  // }
}
