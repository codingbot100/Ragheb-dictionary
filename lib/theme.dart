// import 'package:flutter/material.dart';

// enum AppMode {
//   light,
//   dark,
//   custom,
// }

// class ModeColors extends StatefulWidget {
//   @override
//   _ModeColorsState createState() => _ModeColorsState();
// }

// class _ModeColorsState extends State<ModeColors> {
//   AppMode _currentMode = AppMode.light;

//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData;

//     switch (_currentMode) {
//       case AppMode.light:
//         themeData = ThemeData.light().copyWith(
//           // primaryColor: LightModeColors.primaryColor,
//           // accentColor: LightModeColors.secondaryColor,
//           scaffoldBackgroundColor: LightModeColors.backgroundColor,
//           appBarTheme: AppBarTheme(color: LightModeColors.appBarColor),
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//             selectedItemColor: LightModeColors.bottomNavColor,
//           ),
//           textTheme: TextTheme(
//             bodyText1: TextStyle(color: LightModeColors.textColor),
//             bodyText2: TextStyle(color: LightModeColors.textColor),
//             button: TextStyle(color: LightModeColors.buttonColor),
//             headline6: TextStyle(color: LightModeColors.textColor),
//           ),
//         );
//         break;
//       case AppMode.dark:
//         themeData = ThemeData.dark().copyWith(
//           primaryColor: DarkModeColors.primaryColor,
//           // accentColor: DarkModeColors.secondaryColor,
//           scaffoldBackgroundColor: DarkModeColors.backgroundColor,
//           appBarTheme: AppBarTheme(color: DarkModeColors.appBarColor),
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//             selectedItemColor: DarkModeColors.bottomNavColor,
//           ),
//           textTheme: TextTheme(
//             bodyText1: TextStyle(color: DarkModeColors.textColor),
//             bodyText2: TextStyle(color: DarkModeColors.textColor),
//             button: TextStyle(color: DarkModeColors.buttonColor),
//             headline6: TextStyle(color: DarkModeColors.textColor),
//           ),
//         );
//         break;
//       case AppMode.custom:
//         themeData = ThemeData.dark().copyWith(
//           primaryColor: CustomModeColors.primaryColor,
//           // accentColor: CustomModeColors.secondaryColor,
//           scaffoldBackgroundColor: CustomModeColors.backgroundColor,
//           appBarTheme: AppBarTheme(color: CustomModeColors.appBarColor),
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//             selectedItemColor: CustomModeColors.bottomNavColor,
//           ),
//           textTheme: TextTheme(
//             bodyText1: TextStyle(color: CustomModeColors.textColor),
//             bodyText2: TextStyle(color: CustomModeColors.textColor),
//             button: TextStyle(color: CustomModeColors.buttonColor),
//             headline6: TextStyle(color: CustomModeColors.textColor),
//           ),
//         );
//         break;
//     }

//     return MaterialApp(
//       title: 'Mode Colors',
//       theme: themeData,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Mode Colors'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Current Mode:',
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 _currentMode.toString().split('.').last,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _currentMode = _getNextMode(_currentMode);
//             });
//           },
//           tooltip: 'Switch Mode',
//           child: Icon(Icons.swap_horiz),
//         ),
//       ),
//     );
//   }

//   AppMode _getNextMode(AppMode currentMode) {
//     switch (currentMode) {
//       case AppMode.light:
//         return AppMode.dark;
//       case AppMode.dark:
//         return AppMode.custom;
//       case AppMode.custom:
//         return AppMode.light;
//     }
//   }
// }

// class LightModeColors {
//   static final primaryColor = Colors.blue;
//   static final secondaryColor = Colors.green;
//   static final backgroundColor = Colors.white;
//   static final appBarColor = Colors.blue;
//   static final bottomNavColor = Colors.blue;
//   static final textColor = Colors.black;
//   static final buttonColor = Colors.blue;
// }

// class DarkModeColors {
//   static final primaryColor = Colors.indigo;
//   static final secondaryColor = Colors.deepOrange;
//   static final backgroundColor = Colors.black;
//   static final appBarColor = Colors.indigo;
//   static final bottomNavColor = Colors.indigo;
//   static final textColor = Colors.white;
//   static final buttonColor = Colors.indigo;
// }

// class CustomModeColors {
//   static final primaryColor = Colors.teal;
//   static final secondaryColor = Colors.purple;
//   static final backgroundColor = Colors.grey[900];
//   static final appBarColor = Colors.teal;
//   static final bottomNavColor = Colors.teal;
//   static final textColor = Colors.white;
//   static final buttonColor = Colors.teal;
// }

// void main() {
//   runApp(ModeColors());
// }
