import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController3 extends GetxController {
  Rx<ThemeData> themeData = lightTheme.obs;

  final String _themeKey = 'theme';

  @override
  void onInit() {
    super.onInit();
    // Remove theme loading from here
  }

  void toggleTheme() {
    if (themeData.value == lightTheme) {
      themeData.value = darkTheme;
    } else {
      themeData.value = lightTheme;
    }
    saveTheme();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, themeData.value == darkTheme);
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // Define your dark theme properties here
);

