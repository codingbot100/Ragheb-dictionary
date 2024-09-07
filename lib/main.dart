// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/Theme_Color.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeData.dart';
import 'package:ragheb_dictionary/splashScreen.dart';

main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  var box2 = await Hive.openBox('mybox2');

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    // splash.loadData();
  }

  final splash = Get.put(splashclass());
  @override
  Widget build(BuildContext context) {
    final _meBox = Hive.box('mybox');
    ThemeData_1 themeData_1 = ThemeData_1();

    return Obx(() {
      return GetMaterialApp(
        transitionDuration: Duration(milliseconds: 500),
        debugShowCheckedModeBanner: false,
        theme: themeManager.themebo.value
            ? themeData_1.CreateDarkTheme(dbfont.FontFamily)
            : themeData_1.CreateLightTheme(dbfont.FontFamily),
        home: Scaffold(
          body: AnimatedSwitcher(
            duration:
                Duration(milliseconds: 1000), // Adjust the duration as needed
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: SplashScreen_Animated(),
            key: Key(themeManager.themebo.value
                .toString()), // Key to trigger animation on theme change
          ),
        ),
      );
    });
  }
}
