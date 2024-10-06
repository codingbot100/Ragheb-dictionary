// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeData.dart';
import 'package:ragheb_dictionary/Setting/settingsPages/About_us.dart';
import 'package:ragheb_dictionary/Setting/settingsPages/about_ragheb_dictionary.dart';
import 'package:ragheb_dictionary/Setting/info_page.dart';
import 'package:ragheb_dictionary/Widgets/Panel.dart';
import 'package:get/get.dart';

class MySettingsPage extends StatefulWidget {
  final void Function() onChange;
  MySettingsPage({
    super.key,
    required this.onChange,
  });

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  final thememanger = Get.put(ThemeManager());
  final dbfont = Get.put(ToDoDataBaseFont());
  final _meBox = Hive.box('mybox');
  final _meBox2 = Hive.box('mybox2');

  ToDoDataBaseFont Db_Font = ToDoDataBaseFont();
  var fontFamile2 = 'YekanBakh';
  final fontSizeTitle = 20.0;
  double fontSizeSubTitle = 10.0;
  // final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  // var listColor = Color.fromARGB(255, 97, 158, 152);
  // Color MyButtonColor = Colors.transparent;
  int fontOption = 0;
  ToDo_FontController db = new ToDo_FontController();
  ThemeDatabase ThemeClass = ThemeDatabase();
  int index = 2;
  final ThemeManager themeManager = Get.find();
  @override
  void initState() {
    themeclass.loadData();
    if (_meBox.get('TODOSlid') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    if (_meBox2.get('FontFamily') == null) {
      Db_Font.createInitialData();
    } else {
      Db_Font.loadData();
    }
    Db_Font.loadData();
    super.initState();
    thememanger.loadData;
    // _loadData();
  }

  List lable_slider = ["ریز", "کوچک ", "بزرگ"];
  @override
  void updatePrices(double added, int removed) {
    int extra = added ~/ 5 * 2;
    int reduced = removed ~/ 5 * 2;

    // اعمال تغییرات به مقادیر فونت بر اساس مقادیر مربوطه
    if (db.name > 30) {
      db.Descrption += extra;
      db.FootNot += extra;
      db.SearchName += extra;
      db.RecentSearch += extra;
    } else if (db.name < 30) {
      db.Descrption -= reduced;
      db.FootNot -= reduced;
      db.SearchName -= reduced;
      db.RecentSearch -= reduced;
    }
  }

  ThemeDatabase themeclass = ThemeDatabase();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    bool isTable = screenWidth > 600;
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: isTable ? 25 : 10,
                right: isTable ? 25 : 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Panel(
                      onChange: () {
                        widget.onChange();
                      },
                      Title: "تنظیمات"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: isTable ? 410 : 240,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                            color: !themeManager.themebo.value
                                ? Color.fromRGBO(255, 255, 255, 0.5)
                                : Color.fromRGBO(28, 28, 28, 1),
                            boxShadow: thememanger.themebo.value != true
                                ? [
                                    BoxShadow(
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(0, 0, 0, 0.07),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    )
                                  ]
                                : []),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: isTable ? 25 : 15,
                            right: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: isTable
                                        ? screenWidth * 0.18
                                        : screenWidth * 0.15,
                                    child: Text(
                                      ' نوع قلم: ',
                                      style: TextStyle(
                                        color: thememanger.themebo.value != true
                                            ? Color.fromRGBO(82, 82, 82, 1)
                                            : Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: "YekanBakh",
                                        fontWeight: FontWeight.w600,
                                        fontSize: isTable ? 25 : 14,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width:
                                          isTable ? screenWidth * 0.71 : null,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FontButton(
                                              "یکان بخ", 55, 0, 'YekanBakh'),
                                          FontButton(
                                              "  یکان", 55, 1, 'IRANSansX'),
                                          FontButton(
                                              " وزیر مت", 60, 2, 'Vazirmatn'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'اندازه قلم : ',
                                    style: TextStyle(
                                      color: thememanger.themebo.value != true
                                          ? Color.fromRGBO(82, 82, 82, 1)
                                          : Color.fromRGBO(153, 153, 153, 1),
                                      fontFamily: "YekanBakh",
                                      fontWeight: FontWeight.w600,
                                      fontSize: isTable ? 25 : 14,
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, right: 27),
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackHeight: isTable ? 10 : 5,
                                          valueIndicatorTextStyle: TextStyle(
                                              fontSize: isTable ? 22 : 12,
                                              fontFamily: "YekanBakh",
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  0, 150, 136, 1)),
                                          valueIndicatorColor:
                                              Colors.transparent,
                                          activeTrackColor: Color.fromRGBO(
                                              147,
                                              147,
                                              147,
                                              1), // Customizing track color
                                          inactiveTrackColor: Color.fromRGBO(
                                              147,
                                              147,
                                              147,
                                              1), // Customizing track color

                                          overlayColor: Colors
                                              .transparent, // Customizing overlay color to transparent

                                          thumbShape: RoundSliderThumbShape(
                                            elevation: 0,
                                            enabledThumbRadius: isTable
                                                ? 15
                                                : 8.0, // Width and height of main dot
                                          ),

                                          overlayShape: RoundSliderOverlayShape(
                                            overlayRadius:
                                                0.0, // Disabling overlay
                                          ),

                                          activeTickMarkColor: Colors
                                              .transparent, // Hiding inactive tick marks
                                        ),
                                        child: Slider(
                                            value: db.name.clamp(
                                                isTable ? 50.0 : 28.0,
                                                isTable
                                                    ? 80.0
                                                    : 48.0), // Clamp to ensure it's within range
                                            min: isTable ? 50.0 : 28.0,
                                            max: isTable ? 80.0 : 48.0,
                                            divisions: 2,
                                            label: db.name == 50
                                                ? "ریز"
                                                : db.name == 65
                                                    ? "بزرگ"
                                                    : "بزرگتر",
                                            onChanged: (double value) {
                                              setState(() {
                                                db.name = value;
                                                db.updateDataTypes();
                                                db.updateDataBase();
                                                // print(value);
                                                // print(db.FootNot);
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                // height: 85,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "متن آزمایشی :",
                                      style: TextStyle(
                                        fontSize: isTable ? 26 : 13,
                                        fontWeight: FontWeight.w400,
                                        color: thememanger.themebo.value != true
                                            ? Color.fromRGBO(82, 82, 82, 1)
                                            : Color.fromRGBO(153, 153, 153, 1),
                                        fontFamily: "YekanBakh",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10, top: isTable ? 12 : 0),
                                      child: Text(
                                        softWrap: true,
                                        "بهترین شما نافع ترین تان به بقیه است. (حدیث شریف)",
                                        style: TextStyle(
                                          fontSize: db.testText,
                                          fontWeight: FontWeight.w600,
                                          color: thememanger.themebo.value !=
                                                  true
                                              ? Color.fromRGBO(82, 82, 82, 1)
                                              : Color.fromRGBO(
                                                  153, 153, 153, 1),
                                          fontFamily: Db_Font.FontFamily,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: isTable ? 160 : 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.ltr,
                          children: [
                            Mylist(
                                listName: 'درباره فرهنگ لغت راغب',
                                OntapLis: () {
                                  Get.to(() => about_ragheb_dictionary(),
                                      transition: Transition.leftToRight,
                                      duration: Duration(milliseconds: 300));
                                }),
                            Mylist(
                                listName: 'درباره سازنده گان اپلیکیشن',
                                OntapLis: () {
                                  Get.to(() => about_Us(),
                                      transition: Transition.leftToRight,
                                      duration: Duration(milliseconds: 300));
                                }),
                            // Mylist(
                            //     listName: 'ارئه بازخورد',
                            //     OntapLis: () {})
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int calculateIndex(double value) {
    if (value <= 20) {
      return 0;
    } else if (value <= 30) {
      return 1;
    } else if (value <= 40) {
      return 2;
    } else if (value <= 50) {
      return 3;
    } else {
      return 4;
    }
  }

  Widget FontButton(
      String fontName, double width, int fontBorder, String fontFamily) {
    var screenWidth = MediaQuery.of(context).size.width;
    bool isTable = screenWidth > 600;
    return TextButton(
      onPressed: () {
        setState(() {
          Db_Font.FontFamily = fontFamily;
          Db_Font.borderFont = fontBorder;

          Db_Font.updateDataBase();
        });
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          width: isTable ? 89 : 66,
          height: isTable ? 48 : 26,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Db_Font.borderFont == fontBorder
                  ? Border.all(
                      color: Db_Font.borderFont == fontBorder
                          ? Color.fromRGBO(0, 150, 137, 0.929)
                          : Color.fromRGBO(147, 147, 147, 1))
                  : null,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              fontName,
              style: TextStyle(
                color: thememanger.themebo.value != true
                    ? Db_Font.borderFont == fontBorder
                        ? Color.fromRGBO(0, 150, 137, 1)
                        : Color.fromRGBO(147, 147, 147, 1)
                    : Db_Font.borderFont == fontBorder
                        ? Color.fromRGBO(0, 150, 137, 1)
                        : Colors.white,
                fontFamily: 'YekanBakh',
                fontWeight: FontWeight.w600,
                fontSize: isTable ? 22 : 13,
              ),
            ),
          )),
    );
  }
}
