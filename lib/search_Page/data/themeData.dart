import 'package:hive_flutter/hive_flutter.dart';

class ThemeDatabase {
  late int themeCount ;

  final _meBox2 = Hive.box('mybox2');

  void createInitialData() {
    themeCount = 0;
  }

  void loadData() {
    themeCount = _meBox2.get("themedata");
  }

  void updateDataBase() {
    _meBox2.put('themedata', themeCount);
  }

  void incrementThemeCount() {
    themeCount++;
    if (themeCount > 2) {
      themeCount = 0; // Reset the theme count if it exceeds the maximum value
    }
    updateDataBase(); // Save the updated theme count
  }
}
