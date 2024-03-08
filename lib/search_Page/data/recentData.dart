import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase5 {
  List favorite = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    favorite = [];
  }

  void loadData() {
    favorite = _meBox.get("TODORECENT");
  }

  void updateDataBase() {
    _meBox.put('TODORECENT', favorite);
  }

//
}
