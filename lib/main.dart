// ignore_for_file: unused_local_variable

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/Theme.dart';
import 'package:ragheb_dictionary/WelcomScreen.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/themeData.dart';

main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  var box2 = await Hive.openBox('mybox2');

  runApp(
    MyApp(),
  );
}

class SplashScreen_Animated extends StatelessWidget {
  SplashScreen_Animated({super.key});
  final splash = Get.put(splashclass());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: SvgPicture.asset(
              'Image_WelcomPage/Main Logo.svg',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'فرهنگ لغت راغب ',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "YekanBakh",
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      nextScreen: splash.checkPage.value ? MyAppNavigator() : WelcomScreen(),
      backgroundColor: Color.fromRGBO(0, 150, 136, 1),
      splashIconSize: 300,
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      animationDuration: Duration(seconds: 1),
    );
  }
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
    splash.loadData();
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
