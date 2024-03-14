import 'package:hive_flutter/hive_flutter.dart';

class ToDoRecent {
  List<String> favorite = [];
  List<String> dateAndTime = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    // You can initialize your lists here if needed.
    favorite = [];
    dateAndTime = [];
  }

  void loadData() {
    // Make sure to handle null values returned from Hive.
    favorite = _meBox.get("TODORECENT") ?? [];
    dateAndTime = _meBox.get("TODODATEANDTIME") ?? [];
  }

  void addToFavorites(String item) {
    favorite.add(item);
    String currentDateAndTime = DateTime.now().toString();
    dateAndTime.add(currentDateAndTime);
    updateDataBase();
  }

  void updateDataBase() {
    _meBox.put('TODORECENT', favorite);
    _meBox.put('TODODATEANDTIME', dateAndTime);
  }
}
