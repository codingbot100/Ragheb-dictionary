// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/searchPage/settingsPages.dart/About_us.dart';
import 'package:ragheb_dictionary/search_Page/searchPage/settingsPages.dart/about_ragheb_dictionary.dart';
import 'package:ragheb_dictionary/HomePage/theme.dart';
import 'package:ragheb_dictionary/Setting/CircleContainer.dart';
import 'package:ragheb_dictionary/Setting/FontOptionButton.dart';
import 'package:ragheb_dictionary/Setting/MyList.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MySettingsPage extends StatefulWidget {
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  var fontsCl = fontsClass();

  var fontsSizeClass = fontsize();
  final CAD = Get.put(ColorsClass());
  var them1 = new MyTheme();
  final _meBox = Hive.box('mybox');
  final _meBox2 = Hive.box('mybox2');

  ToDoDataBaseFont Db_Font = ToDoDataBaseFont();
  var fontFamile2 = 'YekanBakh';
  final fontSizeTitle = 20.0;
  double fontSizeSubTitle = 10.0;
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var listColor = Color.fromARGB(255, 97, 158, 152);
  int fontOption = 0;
  final MyTheme theme = MyTheme();
  ToDodatabase6 db = new ToDodatabase6();
  @override
  void initState() {
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
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontFamile2 = prefs.getString('fontFamile2') ?? 'YekanBakh';
      fontOption = prefs.getInt('value') ?? 0;
      fontSizeSubTitle = prefs.getDouble("value1") ?? 13.0;
    });
  }

  @override
  _saveString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fontFamile2', fontFamile2);
    await prefs.setInt('value', fontOption);
    await prefs.setDouble('value1', fontSizeSubTitle);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'تنظیمات',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: theme.colorPrimary,
                            fontFamily: Db_Font.FontFamily,
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 161,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2, 2),
                                          color: Color.fromRGBO(
                                              251, 103, 103, 0.078))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            ' نوع قلم: ',
                                            style: TextStyle(
                                              fontFamily: fontsCl.fonts[2],
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          FontOptionButton(
                                            fontName: 'یکان',
                                            isSelected: fontOption == 0,
                                            onTap: () {
                                              setState(() {
                                                fontOption = 0;
                                                Db_Font.FontFamily = "Yekan";
                                                Db_Font.updateDataBase;
                                                _saveString();
                                                print(Db_Font.FontFamily);
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          FontOptionButton(
                                            fontName: 'ایران سنس ایکس',
                                            isSelected: fontOption == 1,
                                            onTap: () {
                                              setState(() {
                                                fontOption = 1;
                                                Db_Font.FontFamily =
                                                    "IRANSansX";
                                                Db_Font.updateDataBase;
                                                print(Db_Font.FontFamily);

                                                _saveString();
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FontOptionButton(
                                            fontName: 'یکان بخ',
                                            isSelected: fontOption == 2,
                                            onTap: () {
                                              setState(() {
                                                fontOption = 2;
                                                Db_Font.FontFamily =
                                                    "YekanBakh";
                                                Db_Font.updateDataBase;
                                                _saveString();
                                                print(Db_Font.FontFamily);
                                              });
                                            },
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
                                              fontFamily: fontsCl.fonts[2],
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Flexible(
                                            child: Slider(
                                                value: db.name,
                                                min: 15,
                                                max: 40,
                                                divisions: 10,
                                                label:
                                                    db.name.round().toString(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    db.name = value;
                                                    db.updateDataTypes();
                                                    db.updateDataBase();
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'نوع رنگ:',
                                              style: TextStyle(
                                                fontFamily: "YekanBakh",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                              ),
                                            ),
                                            circleContainer(
                                                circleColor: Color.fromRGBO(
                                                    255, 255, 255, 0.5)),
                                            circleContainer(
                                                circleColor: Color.fromRGBO(
                                                    77, 110, 129, 1)),
                                            circleContainer(
                                                circleColor: Color.fromRGBO(
                                                    207, 141, 118, 1)),
                                            circleContainer(
                                                circleColor: Color.fromRGBO(
                                                    170, 83, 255, 0.5)),
                                            circleContainer(
                                                circleColor: Color.fromRGBO(
                                                    59, 55, 88, 1)),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    Mylist(
                                        listName: 'درباره فرهنگ لغت راغب',
                                        OntapLis: () {
                                          Get.to(
                                              () => about_ragheb_dictionary(),
                                              transition: Transition.cupertino);
                                        }),
                                    Mylist(
                                        listName: 'درباره سازنده گان اپلیکیشن',
                                        OntapLis: () {
                                          Get.to(() => about_Us(),
                                              transition: Transition.cupertino);
                                        }),
                                    Mylist(
                                        listName: 'ارئه بازخورد',
                                        OntapLis: () {})
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
