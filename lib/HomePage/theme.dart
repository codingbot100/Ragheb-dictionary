import 'package:flutter/material.dart';

class MyTheme {
  // Colors
  Color colorPrimary = Color(0xFF009688); // Replace with your default color
  Color colorBackground = Color.fromRGBO(245, 245, 220, 1);

  // Dark mode toggle
  bool isDarkMode = false;

  // Method to toggle between dark and light mode
  void toggleDarkMode() {
    isDarkMode = !isDarkMode;

    // Update colors based on mode
    if (isDarkMode) {
      colorPrimary = Color(0xFFB0BEC5);
      colorBackground = Color(0xFF212121);
      // Update other dark mode colors
    } else {
      colorPrimary = Color(0xFF009688);
      colorBackground = Color.fromRGBO(245, 245, 220, 1);
    }
  }
}
