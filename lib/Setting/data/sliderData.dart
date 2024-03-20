import 'package:hive_flutter/hive_flutter.dart';


class ToDodatabase6 {
  late double name;
  late double Descrption;
  late double FootNot;
  late double SearchName;
  late double RecentSearch;
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    name = 30;
    Descrption = 12;
    FootNot = 10;
    SearchName = 17;
    RecentSearch = 17;
  }

  void updateDataTypes() {
    double increment = (name - 30) / 5 * 2;

    Descrption = 12 + increment;
    FootNot = 10 + increment;
    SearchName = 17 + increment;
    RecentSearch = 17 + increment;

    // اضافه یا کم کردن دو واحد به مقادیر دیگر دیتا تایپ‌ها
    if (name % 5 != 0) {
      double adjustment = 2 * ((name > 30) ? 1 : -1);
      Descrption += adjustment;
      FootNot += adjustment;
      SearchName += adjustment;
      RecentSearch += adjustment;
    }
  }

  void loadData() {
    name = _meBox.get("TODOSlid") ?? 30;
    Descrption = _meBox.get("TODDescription") ?? 12;
    FootNot = _meBox.get("TODOFootnot") ?? 10;
    SearchName = _meBox.get("TODOSearchName") ?? 17;
    RecentSearch = _meBox.get("TODORearchName") ?? 17;
  }

  void updateDataBase() {
    _meBox.put('TODOSlid', name);
    _meBox.put('TODDescription', Descrption);
    _meBox.put('TODOFootnot', FootNot);
    _meBox.put('TODOSearchName', SearchName);
    _meBox.put('TODORearchName', RecentSearch);
  }
}
