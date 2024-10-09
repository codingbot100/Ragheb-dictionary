import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeManager extends GetxController {
  var themebo = false.obs;

  final _meBox2 = Hive.box('mybox2');
  void changeMode() {
    themebo.value = !themebo.value;
    _meBox2.put('theme', themebo.value);
  }

  void loadData() {
    themebo.value = _meBox2.get("themebo") ??
        false; // Initialize themebo with the value from Hive or default to false
  }

  void updateDataBase() {
    _meBox2.put('themebo', themebo.value); // Store the value of themebo in Hive
  }
}
