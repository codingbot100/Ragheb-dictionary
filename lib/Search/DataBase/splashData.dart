import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


class splashclass extends GetxController {
  var checkPage = false.obs;

  final _meBox2 = Hive.box('mybox2');
  void savePage() {
    checkPage.value = true;
    _meBox2.put('theme', checkPage.value);
  }

  void loadData() {
    checkPage.value = _meBox2.get("checkpage") ?? false; // Initialize themebo with the value from Hive or default to false
  }

  void updateDataBase() {
    _meBox2.put('checkpage', checkPage.value); // Store the value of themebo in Hive
  }
}
