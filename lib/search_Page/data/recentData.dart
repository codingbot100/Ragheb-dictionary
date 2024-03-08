import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase5 {
  List favorite = [];
  List dateAndTime = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    favorite = [];
    dateAndTime = [];
  }

  void loadData() {
    favorite = _meBox.get("TODORECENT");
    dateAndTime = _meBox.get("TODODATEANDTIME");
  }

  void addToForites(String item) {
    favorite.add(item);
    String currentDateAndTime = DateTime.now().toString();
    dateAndTime.add(currentDateAndTime);
    updateDataBase();
  }

  void updateDataBase() {
    _meBox.put('TODORECENT', favorite);
    _meBox.put('TODORECENT_DATE_TIME', dateAndTime);
  }

//
}
