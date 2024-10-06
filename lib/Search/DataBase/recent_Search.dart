import 'package:hive_flutter/hive_flutter.dart';
//2
class ToDoRecent {
  List RecentSearch = [];
  List dateAndTime = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    // You can initialize your lists here if needed.
    RecentSearch = [];
    dateAndTime = [];
  }

  void loadData() {
    // Make sure to handle null values returned from Hive.
    RecentSearch = _meBox.get("TODORECENT") ?? [];
    dateAndTime = _meBox.get("TODODATEANDTIME") ?? [];
  }

  void addToRecent(String item) {
    RecentSearch.add(item);
    String currentDateAndTime = DateTime.now().toString();
    dateAndTime.add(currentDateAndTime);
    updateDataBase();
  }

  void ClearRecent() {
    RecentSearch.clear();
    updateDataBase();
  }

  void updateDataBase() {
    _meBox.put('TODORECENT', RecentSearch);
    _meBox.put('TODODATEANDTIME', dateAndTime);
  }
}
