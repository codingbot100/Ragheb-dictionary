import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class splashclass extends GetxController{
  var  checkPage = false.obs;
   final _meBox = Hive.box('mybox');

 

  void loadData() {
    checkPage = _meBox.get("checkPage") ?? false;
  }

  void updateDataBase() {
    _meBox.put('checkPage', checkPage);
  }

}