import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase3 {
  List favorite = [];
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    favorite = [];
  }

  void loadData() {
    favorite = _meBox.get("TODOLIST") ?? [];
  }

  void updateDataBase() {
    _meBox.put('TODOLIST', favorite);
  }

//
}
