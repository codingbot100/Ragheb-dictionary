import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase6 {
  late double slidefont;

  final _meBox = Hive.box('mybox');

  void createInitialData() {
    slidefont = 15;
  }

  void loadData() {
    slidefont = _meBox.get("TODOSlid");
  }

  void updateDataBase() {
    _meBox.put('TODOSlid', slidefont);
  }
}
