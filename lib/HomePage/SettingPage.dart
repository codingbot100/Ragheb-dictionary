import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/HomePage/searchPage/settingsPages.dart/about_ragheb_dictionary.dart';
import 'package:ragheb_dictionary/HomePage/theme.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyTheme().loadDarkModeState();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySettingsPage(),
    );
  }
}

class MySettingsPage extends StatefulWidget {
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  final ThemeController _themeController = Get.put(ThemeController());

  final CAD = Get.put(ColorsClass());
  String fontFamile = 'Yekan';
  var them1 = new MyTheme();
  bool isDark = true;

  var fontFamile2 = 'YekanBakh';
  final fontSizeTitle = 20.0;
  double fontSizeSubTitle = 10.0;
  // final colorPrimary = Color(0xFF009688);
  // final colorBackground = Color.fromRGBO(245, 245, 220, 1);
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var listColor = Color(0xFF009688);
  int fontOption = 0;
  final MyTheme theme = MyTheme();

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Container(
              width: 420,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, right: 20),
                    child: Text(
                      'تنظیمات',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: theme.colorPrimary,
                        fontFamily: fontFamile2,
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 230,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: CAD.colorBackground.value,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(2, 2),
                              color: Color.fromRGBO(0, 0, 0, 0.08))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' نوع قلم: ',
                                style: TextStyle(
                                  fontFamily: fontFamile2,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
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
                                    fontFamile2 = 'Yekan';
                                    _saveString();
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
                                    fontFamile2 = 'IRANSansX';
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
                                    fontFamile2 = 'YekanBakh';
                                    _saveString();
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'اندازه قلم : ',
                                style: TextStyle(
                                  fontFamily: fontFamile2,
                                  fontWeight: FontWeight.w700,
                                  fontSize: fontSizeSubTitle,
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                    value: fontSizeSubTitle,
                                    min: 10,
                                    max: 25,
                                    divisions: 5,
                                    label: fontSizeSubTitle.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        fontSizeSubTitle = value;
                                      });
                                    }),
                              )
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'نوع رنگ:',
                                  style: TextStyle(
                                    fontFamily: fontFamile2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSizeSubTitle,
                                  ),
                                ),
                                circleContainer(
                                    circleColor:
                                        Color.fromRGBO(255, 255, 255, 0.5)),
                                circleContainer(
                                    circleColor:
                                        Color.fromRGBO(77, 110, 129, 1)),
                                circleContainer(
                                    circleColor:
                                        Color.fromRGBO(207, 141, 118, 1)),
                                circleContainer(
                                    circleColor:
                                        Color.fromRGBO(170, 83, 255, 0.5)),
                                circleContainer(
                                    circleColor: Color.fromRGBO(59, 55, 88, 1)),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  theme.isDarkMode
                                      ? "حالت روز:"
                                      : ' حالت تاریک:',
                                  style: TextStyle(
                                      color: theme.colorPrimary,
                                      fontFamily: fontFamile2,
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSizeSubTitle)),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInBack,
                                child: IconButton(
                                    onPressed: () {
                                      _themeController.toggleTheme();
                                    },
                                    icon: theme.isDarkMode
                                        ? Icon(Icons.wb_sunny_outlined)
                                        : Icon(
                                            Icons.nightlight_round_outlined)),
                              )
                            ],
                          )
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection: TextDirection.ltr,
                      children: [
                        Mylist(
                            listName: 'درباره فرهنگ لغت راغب',
                            OntapLis: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            about_ragheb_dictionary()));
                              });
                              ;
                            }),
                        Mylist(
                            listName: 'درباره سازنده گان اپلیکیشن',
                            OntapLis: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => about_Us()));
                              });
                            }),
                        Mylist(listName: 'ارئه بازخورد', OntapLis: () {})
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FontOptionButton extends StatelessWidget {
  final CAD = Get.put(ColorsClass());
  final String fontName;
  final bool isSelected;
  final VoidCallback onTap;

  final MyTheme theme = MyTheme();

  FontOptionButton({
    required this.fontName,
    required this.isSelected,
    required this.onTap,
  });

  final int widh = 40;

  get colorPrimary => Color(0xFF009688);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (fontName == 'ایران سنس ایکس') ? 92 : 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: isSelected
              ? Border.all(color: Color.fromRGBO(0, 150, 136, 1))
              : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Container(
            child: Text(
              fontName,
              style: TextStyle(
                color: isSelected ? CAD.colorPrimary.value : CAD.colorWords,
                fontFamily: 'YekanBakh',
                fontWeight: FontWeight.w700,
                fontSize: _MySettingsPageState().fontSizeSubTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Mylist extends StatelessWidget {
  final thme = MyTheme();
  final String listName;
  final VoidCallback OntapLis;
  Mylist({required this.listName, required this.OntapLis});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OntapLis,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: thme.colorBackground,
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 2), color: Color.fromRGBO(0, 0, 0, 0.08))
              ]),
          height: 42,
          child: ListTile(
            trailing: Icon(
              Icons.arrow_back_ios_new,
              size: 17,
            ),
            leading: Text(
              listName,
              style: TextStyle(
                fontFamily: _MySettingsPageState().fontFamile2,
                fontWeight: FontWeight.w700,
                color: _MySettingsPageState().listColor,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class circleContainer extends StatefulWidget {
  late final circleColor;
  circleContainer({required this.circleColor});

  @override
  State<circleContainer> createState() => _circleContainerState();
}

class _circleContainerState extends State<circleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(100.0)),
    );
  }
}
