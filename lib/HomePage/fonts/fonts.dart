// // import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MyTheme {
//   // Existing code...

//   static const String fontKey = 'Yekan';

//   Future<void> saveSelectedFont(String fontName) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(fontKey, fontName);
//   }

//   Future<String?> getSelectedFont() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(fontKey);
//   }
// }
