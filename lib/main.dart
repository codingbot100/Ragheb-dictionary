// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/SplashScreen.dart';
import 'package:ragheb_dictionary/Theme.dart';
import 'package:ragheb_dictionary/WelcomScreen.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/themeData.dart';
import 'package:ragheb_dictionary/search_Page/data/splashData.dart';

 main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  var box2 = await Hive.openBox('mybox2');

  runApp(
    Start(),
  );
}


class Start extends StatefulWidget {
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final _meBox2 = Hive.box('mybox2');
  ToDoDataBaseFont dbfont = ToDoDataBaseFont();
  ThemeDatabase ThemeClass = ThemeDatabase();

  late ThemeData theme;
  final ThemeManager themeManager = Get.put(ThemeManager());

  @override
  void initState() {
    setState(() {
      if (_meBox2.get('FontFamily') == null) {
        dbfont.createInitialData();
      } else {
        dbfont.loadData();
      }
    });
    themeManager.loadData();
    super.initState();
    splash.loadData();
  }

  final splash = Get.put(splashclass());
  @override
  Widget build(BuildContext context) {
    final _meBox = Hive.box('mybox');
    ThemeData_1 themeData_1 = ThemeData_1();
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeManager.themebo.value
            ? themeData_1.CreateDarkTheme(dbfont.FontFamily)
            : themeData_1.CreateLightTheme(dbfont.FontFamily),
        home: Scaffold(
          body: splash.checkPage.value ? SplashScreen() : WelcomScreen(),
        ),
      );
    });
  }
}
