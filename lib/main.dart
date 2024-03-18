// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/ThemeManger.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/themData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  var box2 = await Hive.openBox('mybox2');

  runApp(start());
}

class start extends StatefulWidget {
  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  final CAD = Get.put(ColorsClass());
  final _meBox2 = Hive.box('mybox2');
  ThemeManger _themeManger = ThemeManger();
  ToDoDataBaseFont dbFont = ToDoDataBaseFont();
  @override
  void initState() {
    super.initState();
    if (_meBox2.get('FontFamily') == null) {
      dbFont.createInitialData();
    } else {
      dbFont.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(), // Set default light theme
      darkTheme: ThemeData.dark(), // Set default dark theme
      themeMode: ThemeMode.system,
      // theme: ThemeData(
      //     // fontFamily: dbFont.FontFamily,
      //     backgroundColor: Color.fromRGBO(245, 245, 220, 1),
      //     appBarTheme: AppBarTheme(
      //       backgroundColor: Color(0xFFF5F5DC),
      //     )),
      debugShowCheckedModeBanner: false,
      home: MyAppNavigator(),
    );
  }
}
