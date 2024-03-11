import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase7 {
  late String fontFamily;

  final _meBox = Hive.box('mybox');

  void createInitialData() {
    fontFamily = 'YekanBakh';
  }

  void loadData() {
    fontFamily = _meBox.get("TODOfontFamily");
  }

  void updateDataBase() {
    _meBox.put('TODOfontFamily', fontFamily);
  }
}
