import 'package:get/get.dart';

class IncrementController extends GetxController {
  var current = 0.obs;
  var currentMode = false.obs;
  void incrementme() {
    current++;
    currentMode.value =!currentMode.value;
  }
}
