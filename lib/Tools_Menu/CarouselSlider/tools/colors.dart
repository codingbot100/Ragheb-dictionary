import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorsClass extends GetxController {
  var dartMode = true.obs;
  var colorPrimary = Color(0xFF009688).obs;
  var colorBackground = Color.fromRGBO(245, 245, 220, 1).obs;
  var colorWords = Color.fromRGBO(82, 82, 82, 1);

  void toggleDarkMode() {
    dartMode.value = !dartMode.value;

    if (dartMode.value == true) {
      colorPrimary.value = Color(0xFF009688);
      colorBackground.value = Color.fromRGBO(245, 245, 220, 1);
    } else {
      colorPrimary.value = Color(0xFF00796B);
      colorBackground.value = Color.fromRGBO(33, 33, 33, 1);
    }
  }
}

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  Rx<Color> backgroundColor = Color.fromRGBO(245, 245, 220, 1).obs;

  // Define your light theme here
  ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.pink,
  );

  void toggleTheme() async {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    // Update background color based on the current theme
    backgroundColor.value =
        isDarkMode.value ? Colors.black : Color.fromRGBO(245, 245, 220, 1);
  }
}
