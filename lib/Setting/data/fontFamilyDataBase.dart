import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBaseFont {
  var FontFamily  ;

  final _meBox2 = Hive.box('mybox2');

  void createInitialData() {
    FontFamily = 'YekanBakh';
  }

  void loadData() {
    FontFamily = _meBox2.get("FontFamily") ?? '';
  }

  void updateDataBase() {
    _meBox2.put('FontFamily', FontFamily);
  }
}
