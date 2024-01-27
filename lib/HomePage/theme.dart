import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme {
  // Colors
  Color colorPrimary = Color(0xFF009688); // Replace with your default color
  Color colorBackground = Color.fromRGBO(245, 245, 220, 1);

  // Dark mode toggle
  bool isDarkMode = false;

  // Method to toggle between dark and light mode
  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    saveDarkModeState(); // Save the state when toggled

    // Update colors based on mode
    if (isDarkMode) {
      colorPrimary = Color(0xFFB0BEC5);
      colorBackground = Color(0xFF212121);
      // Update other dark mode colors
    } else {
      colorPrimary = Color(0xFF009688);
      colorBackground = Color.fromRGBO(245, 245, 220, 1);
      // Update other light mode colors
    }
  }

  // Method to save dark mode state to SharedPreferences
  Future<void> saveDarkModeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // Method to load dark mode state from SharedPreferences
  Future<void> loadDarkModeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
  }
}
