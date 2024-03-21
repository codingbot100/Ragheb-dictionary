import 'package:hive_flutter/hive_flutter.dart';

class ToDodatabase6 {
  late double name;
  late double Descrption;
  late double FootNot;
  late double SearchName;
  late double RecentSearch;
  late double title_Web;
  late double title_Web_Main;
  late double main_contant;
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    name = 40;
    Descrption = 12;
    FootNot = 10;
    SearchName = 17;
    RecentSearch = 17;
    title_Web = 30;
    main_contant = 17;
    title_Web_Main = 18;
  }

  void updateDataTypes() {
    double increment = (name - 30) / 5 * 2;

    Descrption = 12 + increment;
    FootNot = 10 + increment;
    SearchName = 17 + increment;
    RecentSearch = 17 + increment;
    title_Web = 30 + increment;
    main_contant = 17 + increment;
    title_Web_Main = 18 + increment;

    // اضافه یا کم کردن دو واحد به مقادیر دیگر دیتا تایپ‌ها
    if (name % 5 != 0) {
      double adjustment = 2 * ((name > 40) ? 1 : -1);
      Descrption += adjustment;
      FootNot += adjustment;
      SearchName += adjustment;
      RecentSearch += adjustment;
      title_Web += adjustment;
      main_contant += adjustment;
      title_Web_Main += adjustment;
    }
  }

  void loadData() {
    name = _meBox.get("TODOSlid") ?? 40;
    Descrption = _meBox.get("TODDescription") ?? 12;
    FootNot = _meBox.get("TODOFootnot") ?? 10;
    SearchName = _meBox.get("TODOSearchName") ?? 17;
    RecentSearch = _meBox.get("TODORearchName") ?? 17;
    title_Web = _meBox.get("TODOTitleWeb") ?? 30;
    main_contant = _meBox.get("TODOMainContant") ?? 17;
    title_Web_Main = _meBox.get("TODOTitleWebMain") ?? 18;
  }

  void updateDataBase() {
    _meBox.put('TODOSlid', name);
    _meBox.put('TODDescription', Descrption);
    _meBox.put('TODOFootnot', FootNot);
    _meBox.put('TODOSearchName', SearchName);
    _meBox.put('TODORearchName', RecentSearch);
    _meBox.put('TODOTitleWeb', title_Web);
    _meBox.put('TODOMainContant', main_contant);
    _meBox.put('TODOTitleWebMain', title_Web_Main);
  }
}
