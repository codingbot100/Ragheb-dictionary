// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/themeData.dart';
import 'package:ragheb_dictionary/search_Page/searchPage/settingsPages.dart/About_us.dart';
import 'package:ragheb_dictionary/search_Page/searchPage/settingsPages.dart/about_ragheb_dictionary.dart';
import 'package:ragheb_dictionary/HomePage/theme.dart';
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
  ThemeDatabase ThemeClass = ThemeDatabase();

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
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
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
                            fontFamily: Db_Font.FontFamily,
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 30),
                      //   child: Divider(),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 161,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background, // boxShadow: [
                                    boxShadow: themeclass.themeCount == 2
                                        ? [
                                            BoxShadow(
                                              offset: Offset(2, 2),
                                              color:
                                                  Theme.of(context).shadowColor,
                                            )
                                          ]
                                        : []),
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
                                          FontButton(
                                              "یکان بخ", 55, 0, 'YekanBakh'),
                                          FontButton("ایران سنس ایکس", 100, 1,
                                              'IRANSansX'),
                                          FontButton(
                                              " وزیر مت", 60, 2, 'Vazirmatn'),
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
                                                max: 60,
                                                divisions: 4,
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
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    ThemeClass.themeCount = 0;
                                                    ThemeClass.updateDataBase();

                                                    print(
                                                        ThemeClass.themeCount);
                                                  });
                                                },
                                                child: Text('dark')),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    ThemeClass.themeCount = 1;
                                                    ThemeClass.updateDataBase();

                                                    print(
                                                        ThemeClass.themeCount);
                                                  });
                                                },
                                                child: Text("custome")),

                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    ThemeClass.themeCount = 2;
                                                    ThemeClass.updateDataBase();

                                                    print(
                                                        ThemeClass.themeCount);
                                                  });
                                                },
                                                child: Text("light")),
                                            // circleContainer(
                                            //     circleColor: Color.fromRGBO(
                                            //         255, 255, 255, 0.5)),
                                            // circleContainer(
                                            //     circleColor: Color.fromRGBO(
                                            //         77, 110, 129, 1)),
                                            // circleContainer(
                                            //     circleColor: Color.fromRGBO(
                                            //         207, 141, 118, 1)),
                                            // circleContainer(
                                            //     circleColor: Color.fromRGBO(
                                            //         170, 83, 255, 0.5)),
                                            // circleContainer(
                                            //     circleColor: Color.fromRGBO(
                                            //         59, 55, 88, 1)),
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 160,
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
                                              transition: Transition.fadeIn,
                                              duration:
                                                  Duration(milliseconds: 500));
                                        }),
                                    Mylist(
                                        listName: 'درباره سازنده گان اپلیکیشن',
                                        OntapLis: () {
                                          Get.to(() => about_Us(),
                                              transition: Transition.fadeIn,
                                              duration:
                                                  Duration(milliseconds: 500));
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

  Widget FontButton(
      String fontName, double width, int fontBorder, String fontFamily) {
    return InkWell(
      onTap: () {
        setState(() {
          Db_Font.FontFamily = fontFamily;
          Db_Font.borderFont = fontBorder;
          Db_Font.updateDataBase();
        });
      },
      child: Container(
          width: width,
          height: 25,
          decoration: BoxDecoration(
              border: Db_Font.borderFont == fontBorder
                  ? Border.all(color: Color.fromRGBO(0, 150, 136, 1))
                  : null,
              borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              fontName,
              style: TextStyle(
                fontFamily: 'YekanBakh',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          )),
    );
  }
}
