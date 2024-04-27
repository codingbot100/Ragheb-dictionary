import 'package:hive_flutter/hive_flutter.dart';

class ToDo_FontController {
  late double name;
  late double titile_name;
  late double Descrption;
  late double FootNot;
  late double SearchName;
  late double RecentSearch;
  late double title_Web;
  late double title_Web_Main;
  late double main_contant;
  final _meBox = Hive.box('mybox');

  void createInitialData() {
    name = 30;
    Descrption = 20;
    FootNot = 17;
    SearchName = 17;
    RecentSearch = 17;
    title_Web = 30;
    main_contant = 17;
    title_Web_Main = 18;
    titile_name = 30;
  }

  void updateDataTypes() {
    // Define a linear scaling factor based on the range of name
    double scalingFactor = (name - 30) / 100;

    // Apply scaling to UI elements
    titile_name = 25 + scalingFactor * 30;
    Descrption = 17 + scalingFactor * 40;
    FootNot = 15 + scalingFactor * 40;
    SearchName = 17 + scalingFactor * 50;
    RecentSearch = 17 + scalingFactor * 50;
    title_Web = 30 + scalingFactor * 70;
    main_contant = 17 + scalingFactor * 50;
    title_Web_Main = 18 + scalingFactor * 50;
  }

  void loadData() {
    name = _meBox.get("TODOSlid") ?? 30;
    titile_name = _meBox.get("title_name") ?? 30;
    Descrption = _meBox.get("TODDescription") ?? 15;
    FootNot = _meBox.get("TODOFootnot") ?? 13;
    SearchName = _meBox.get("TODOSearchName") ?? 17;
    RecentSearch = _meBox.get("TODORearchName") ?? 17;
    title_Web = _meBox.get("TODOTitleWeb") ?? 30;
    main_contant = _meBox.get("TODOMainContant") ?? 17;
    title_Web_Main = _meBox.get("TODOTitleWebMain") ?? 18;
  }

  void updateDataBase() {
    _meBox.put('TODOSlid', name);
    _meBox.put('title_name', titile_name);
    _meBox.put('TODDescription', Descrption);
    _meBox.put('TODOFootnot', FootNot);
    _meBox.put('TODOSearchName', SearchName);
    _meBox.put('TODORearchName', RecentSearch);
    _meBox.put('TODOTitleWeb', title_Web);
    _meBox.put('TODOMainContant', main_contant);
    _meBox.put('TODOTitleWebMain', title_Web_Main);
  }
}
