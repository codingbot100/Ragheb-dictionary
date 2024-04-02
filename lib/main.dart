// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/themeData.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  var box2 = await Hive.openBox('mybox2');

  runApp(
    Start(),
  );
}

enum AppMode2 { light, dark, custom }

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
  }

  ThemeData CreateDarkTheme() {
    return ThemeData.dark().copyWith(
      dividerTheme:
          DividerThemeData(thickness: 0.4, color: Colors.grey.shade200),
      indicatorColor: DarkModeColors.indicatorColor,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: DarkModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: DarkModeColors.TextFieldBorder,
              )),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DarkModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DarkModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          )),
      sliderTheme: SliderThemeData(
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 6.0,
          ),
          trackHeight: 6,
          minThumbSeparation: 4,
          activeTrackColor: DarkModeColors.sliderThumb,
          thumbColor: DarkModeColors.sliderThumb,
          overlayColor: DarkModeColors.sliderThumb,
          // inactiveTickMarkColor: DarkModeColors.sliderThumb,
          inactiveTrackColor: DarkModeColors.sliderThumb),
      unselectedWidgetColor: DarkModeColors.unselectedColorIndicator,
      listTileTheme: ListTileThemeData(
          textColor: DarkModeColors.textColormiddle,
          // tileColor: DarkModeColors.ListTile,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: DarkModeColors.borderColor),
          )),
      iconTheme: IconThemeData(color: DarkModeColors.buttonColor),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(DarkModeColors.buttonColor))),
      primaryColor: DarkModeColors.primaryColor,
      secondaryHeaderColor: DarkModeColors.seconderColor,
      scaffoldBackgroundColor: DarkModeColors.backgroundColor,
      appBarTheme: AppBarTheme(color: DarkModeColors.appBarColor),
      bottomAppBarColor: DarkModeColors.bottomNavColor,
      textTheme: TextTheme(
        headline1: TextStyle(
          color: DarkModeColors.descriptionColor,
          fontFamily: dbfont.FontFamily,
        ),
        bodyText1: TextStyle(
          color: DarkModeColors.textColorlarge,
          fontFamily: dbfont.FontFamily,
        ),
        bodyText2: TextStyle(
          color: DarkModeColors.textColormiddle,
          fontFamily: dbfont.FontFamily,
        ),
        button: TextStyle(color: DarkModeColors.buttonColor),
        headline6: TextStyle(color: DarkModeColors.textColormiddle),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          background:
              Color.fromRGBO(0, 0, 0, 0.2), // Set the background color here
          primaryContainer: DarkModeColors.borderColor,
          secondaryContainer: DarkModeColors.contantinerSetting),
    );
  }

  ThemeData CreateLightTheme() {
    return ThemeData.light().copyWith(
      dividerTheme:
          DividerThemeData(thickness: 0.4, color: Colors.grey.shade500),
      shadowColor: Color.fromRGBO(0, 0, 0, 0.08),
      indicatorColor: LightModeColors.indicatorColor,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: LightModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: LightModeColors.TextFieldBorder,
              )),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: LightModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: LightModeColors.TextFieldBorder,
            ),
            borderRadius: BorderRadius.circular(25.0),
          )),
      sliderTheme: SliderThemeData(
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 6.0,
            disabledThumbRadius: 6.0,
          ),
          trackHeight: 6,
          minThumbSeparation: 4,
          activeTrackColor: LightModeColors.sliderThumb,
          // thumbColor: LightModeColors.sliderThumb,
          overlayColor: LightModeColors.sliderThumb,
          // inactiveTickMarkColor: DarkModeColors.sliderThumb,
          inactiveTrackColor: LightModeColors.sliderThumb),
      unselectedWidgetColor: LightModeColors.unselectedColorIndicator,
      listTileTheme: ListTileThemeData(
          textColor: LightModeColors.textColormiddle,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.7, color: LightModeColors.borderColor),
          )),
      iconTheme: IconThemeData(color: LightModeColors.buttonColor),
      // iconButtonTheme: IconButtonThemeData(
      //     style: ButtonStyle(
      //         iconColor: MaterialStatePropertyAll(LightModeColors.buttonColor))),
      primaryColor: LightModeColors.primaryColor,
      secondaryHeaderColor: LightModeColors.seconderColor,
      scaffoldBackgroundColor: LightModeColors.backgroundColor,
      bottomAppBarColor: LightModeColors.bottomNavColor,
      bottomAppBarTheme: BottomAppBarTheme(
        shadowColor: Color.fromRGBO(245, 245, 220, 1),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: LightModeColors.descriptionColor,
          fontFamily: dbfont.FontFamily,
        ),
        bodyText1: TextStyle(
          color: LightModeColors.textColorlarge,
          fontFamily: dbfont.FontFamily,
        ),
        bodyText2: TextStyle(
          color: LightModeColors.textColormiddle,
          fontFamily: dbfont.FontFamily,
        ),
        // button: TextStyle(color: LightModeColors.buttonColor),
        headline6: TextStyle(color: LightModeColors.textColormiddle),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          background:
              Color.fromRGBO(245, 245, 220, 1), // Set the background color here
          primaryContainer: LightModeColors.borderColor,
          secondaryContainer: LightModeColors.contantinerSetting),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _meBox = Hive.box('mybox');

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            themeManager.themebo.value ? CreateDarkTheme() : CreateLightTheme(),
        home: Scaffold(
          body: MyAppNavigator(),
        ),
      );
    });
  }
}

class LightModeColors {
  static final primaryColor = Color(0xFFF5F5DC);
  static final contantinerSetting = Color.fromRGBO(255, 255, 255, 0.5);
  static final seconderColor = Color(0xFFF5F5DC);
  static final backgroundColor = Color.fromRGBO(245, 245, 220, 1);
  static final appBarColor = Colors.indigo;
  static final bottomNavColor = Color.fromRGBO(224, 224, 191, 1);
  static final textColorlarge = Color.fromRGBO(0, 150, 136, 1);
  static final textColormiddle = Color.fromRGBO(82, 82, 82, 1);
  static final dividerColor = Color.fromRGBO(153, 153, 153, 1);
  static final TextFieldBorder = Color.fromRGBO(0, 150, 136, 1);
  static final buttonColor = Color.fromARGB(255, 5, 72, 65);
  static final ListTile = Color.fromRGBO(33, 33, 33, 1);
  static final borderColor = Colors.transparent;
  static final indicatorColor = Color.fromRGBO(0, 150, 136, 1);
  static final unselectedColorIndicator = Color.fromRGBO(82, 82, 82, 1);
  static final inputDecorationTheme = Color.fromRGBO(26, 26, 26, 1);
  static final sliderThumb = Color.fromRGBO(0, 150, 136, 1);
  static final overlaySlider = Color.fromRGBO(147, 147, 147, 0.121);
  static final descriptionColor = Color.fromRGBO(82, 82, 82, 1);
}

class DarkModeColors {
  static final primaryColor = Color(0xFFF5F5DC);
  static final seconderColor = Color(0xFFF5F5DC);
  static final contantinerSetting = Color.fromRGBO(33, 33, 33, 1);

  static final backgroundColor = Color.fromRGBO(33, 33, 33, 1);
  static final appBarColor = Colors.indigo;
  static final bottomNavColor = Color.fromRGBO(21, 21, 21, 1);
  static final textColorlarge = Color.fromRGBO(0, 150, 136, 1);
  static final textColormiddle = Color.fromRGBO(169, 169, 169, 1);
  static final dividerColor = Color.fromRGBO(153, 153, 153, 1);
  static final TextFieldBorder = Color.fromRGBO(0, 150, 136, 1);
  static final buttonColor = Color.fromARGB(255, 5, 72, 65);
  static final ListTile = Color.fromRGBO(33, 33, 33, 1);
  static final borderColor = Color.fromRGBO(51, 51, 51, 1);
  static final indicatorColor = Color.fromRGBO(0, 150, 136, 1);
  static final unselectedColorIndicator = Color.fromRGBO(82, 82, 82, 1);
  static final inputDecorationTheme = Color.fromRGBO(26, 26, 26, 1);
  static final sliderThumb = Color.fromRGBO(0, 150, 136, 1);
  static final overlaySlider = Color.fromRGBO(147, 147, 147, 0.121);
  static final descriptionColor = Color.fromRGBO(255, 255, 255, 1);
}

class CustomModeColors {
  static final primaryColor = Color(0xFFF5F5DC);
  static final seconderColor = Color(0xFFF5F5DC);
  static final contantinerSetting = Color.fromRGBO(33, 33, 33, 1);

  static final backgroundColor = Color.fromRGBO(18, 18, 18, 1);
  static final bottomNavColor = Color.fromRGBO(8, 8, 8, 1);
  static final textColorlarge = Color.fromRGBO(0, 150, 136, 1);
  static final textColormiddle = Color.fromRGBO(204, 204, 204, 1);
  static final dividerColor = Color.fromRGBO(153, 153, 153, 1);
  static final TextFieldBorder = Color.fromRGBO(0, 150, 136, 1);
  static final buttonColor = Color.fromARGB(255, 5, 72, 65);
  static final ListTile = Color.fromRGBO(33, 33, 33, 1);
  static final borderColor = Color.fromRGBO(51, 51, 51, 1);
  static final indicatorColor = Color.fromRGBO(0, 150, 136, 1);
  static final unselectedColorIndicator = Color.fromRGBO(82, 82, 82, 1);
  static final inputDecorationTheme = Color.fromRGBO(26, 26, 26, 1);
  static final sliderThumb = Color.fromRGBO(0, 150, 136, 1);
  static final overlaySlider = Color.fromRGBO(147, 147, 147, 0.121);
  static final descriptionColor = Color.fromRGBO(255, 255, 255, 1);
}
