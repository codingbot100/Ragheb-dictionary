import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBaseFont {
  var FontFamily;
  late int borderFont;

  final _meBox2 = Hive.box('mybox2');

  void createInitialData() {
    FontFamily = 'YekanBakh';
    borderFont = 0;
  }

  void loadData() {
    FontFamily = _meBox2.get("FontFamily");
    borderFont = _meBox2.get("borderFont") ?? 0;
  }

  void updateDataBase() {
    _meBox2.put('FontFamily', FontFamily);
    _meBox2.put('borderFont', borderFont);
  }
}
