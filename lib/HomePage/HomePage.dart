// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Search/RecentPage_Menu.dart';
import 'package:ragheb_dictionary/Search/FavoritePages_menu.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';

class Home extends StatefulWidget {
  final void Function(int) onPageChange;
  final void Function(int) SearchPage;

  const Home({
    Key? key,
    required this.onPageChange,
    required this.SearchPage,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final MyController _myController = Get.put(MyController());
  final ThemeManager themeManager = Get.find();
  ToDoDataBaseFont Db_Font = ToDoDataBaseFont();
  ToDoRecent Recent_db = ToDoRecent();
  ToDo_favorite toDo_favorite = ToDo_favorite();
  final _meBox = Hive.box('mybox');
  final myItems = [
    'images2/2.jpg',
    'images2/3.jpg',
    'images2/4.jpg',
    'images2/5.jpg',
  ];
  int myCurrentIndex = 0;
  final fontFamile = 'Yekan';
  final fontSizeTitle = 18.0;
  final fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color(0xFFF5F5DC);
  var colortitle;
  ToDoRecent toDoRecent = ToDoRecent();

  @override
  void initState() {
    toDoRecent.loadData();
    Db_Font.loadData();
    if (_meBox.get("TODOLIST") == null) {
      toDo_favorite.createInitialData();
    } else {
      toDo_favorite.loadData();
    }
    Recent_db.loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Adjust font size based on screen width
    // double adjustedFontSizeTitle = fontSizeTitle;
    // double adjustedFontSizeSubTitle = fontSizeSubTitle;
    // if (width < 300) {
    //   adjustedFontSizeTitle = fontSizeTitle * 0.8;
    //   adjustedFontSizeSubTitle = fontSizeSubTitle * 0.8;
    // } else if (width > 600) {
    //   adjustedFontSizeTitle = fontSizeTitle * 1.2;
    //   adjustedFontSizeSubTitle = fontSizeSubTitle * 1.2;
    // }
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              top: isTablet ? 20 : 7,
              left: isTablet ? 25 : 10,
              right: isTablet ? 25 : 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          themeManager.changeMode();
                          themeManager.updateDataBase();
                          print(themeManager.themebo);
                        });
                      },
                      icon: themeManager.themebo.value
                          ? Icon(Icons.sunny,
                              size: isTablet ? 40 : 20,
                              color: Color.fromRGBO(0, 150, 136, 1))
                          : SvgPicture.asset(
                              "svg_images/moon.svg",
                              height: isTablet ? 40 : 23,
                            ),
                    ),
                    Text(
                      'فرهنگ لغت راغب',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 153, 136, 1),
                        fontSize: isTablet ? 30 : 20,
                        fontFamily: Db_Font.FontFamily,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: isTablet ? 75.0 : 25),
                          child: TextRow(
                              1,
                              "< مرور همه ",
                              'مقالات وبلاگ',
                              fontFamile: fontFamile,
                              colorPrimary: colorPrimary,
                              context: context,
                              onPageChange: widget.onPageChange,
                              width),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: isTablet ? 55 : 10),
                          child: CarouselSlider1(),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 70, bottom: height * 0.18),
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      widget.SearchPage(2);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color:
                                              Color.fromRGBO(0, 150, 136, 0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: isTablet ? 70 : 47,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "جستجو در واژه گان قرآنکریم",
                                            style: TextStyle(
                                              fontFamily: "YekanBakh",
                                              color: Color.fromRGBO(
                                                  0, 150, 136, 1),
                                              fontSize: isTablet ? 33 : 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: SvgPicture.asset(
                                              "svg_images/search_button.svg",
                                              height: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: toDo_favorite.favorite.isNotEmpty,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: isTablet ? 15 : 0),
                                  child: TextRow(
                                      3,
                                      "< مرور همه ",
                                      'ذخیره شده ها',
                                      fontFamile: fontFamile,
                                      context: context,
                                      colorPrimary: colorPrimary,
                                      onPageChange: widget.onPageChange,
                                      width),
                                ),
                              ),
                              Container(
                                height: (toDo_favorite.favorite.length <= 3)
                                    ? isTablet
                                        ? toDo_favorite.favorite.length * 90
                                        : toDo_favorite.favorite.length * 60
                                    : isTablet
                                        ? 3 * 90
                                        : 3 * 60,
                                child: GetBuilder<MyController>(
                                  builder: (controller) {
                                    return FavoritPage_menu(
                                      length: 0,
                                    );
                                  },
                                ),
                              ),
                              Visibility(
                                visible: toDoRecent.RecentSearch.isNotEmpty,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: isTablet ? 15 : 0),
                                  child: TextRow(
                                      2,
                                      "< مرور همه ",
                                      'جستجو های اخیر',
                                      fontFamile: fontFamile,
                                      context: context,
                                      colorPrimary: colorPrimary,
                                      onPageChange: widget.onPageChange,
                                      width),
                                ),
                              ),
                              RecentPageHomePage(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextRow(
      int currentPage, String firstTitle, String secondTitle, double width,
      {required String fontFamile,
      required BuildContext context,
      required Color colorPrimary,
      required Function(int) onPageChange}) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    return Container(
      // height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onPageChange(currentPage);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                height: 30,
                child: Text(
                  firstTitle,
                  style: TextStyle(
                    fontFamily: fontFamile,
                    fontSize: isTablet ? 20 : 12,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isTablet ? 5 : 17),
              child: Divider(
                // height: 1,
                // thickness: 0.5,
                color: colorPrimary,
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            height: 30,
            child: Text(
              secondTitle,
              style: TextStyle(
                fontFamily: fontFamile,
                fontSize: isTablet ? 20 : 12,
                color: colorPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyController extends GetxController {
  RxInt counter = 0.obs;

  void increment() {
    counter++;
  }
}
