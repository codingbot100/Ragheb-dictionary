// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/Empty_dataBase.dart';
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
  ToDoRecent Recent_db = ToDoRecent();
  ToDoDataBaseFont Db_Font = ToDoDataBaseFont();
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
    Db_Font.loadData();
    themeManager.loadData();
    if (_meBox.get('TODORECENT') == null) {
      Recent_db.createInitialData();
    } else {
      Recent_db.loadData();
    }
    if (_meBox.get("TODORECENT") == null) {
      toDoRecent.createInitialData();
    } else {
      toDoRecent.loadData();
    }

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
    return Scaffold(
      body: SafeArea(
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
                            color: Color.fromRGBO(245, 245, 220, 1))
                        : SvgPicture.asset(
                            "svg_images/moon.svg",
                          ),
                  ),
                  Text(
                    'فرهنگ لغت راغب',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 153, 136, 1),
                      fontSize: fontSizeTitle,
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
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextRow(1, "< مرور همه ", 'مقالات وبلاگ'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CarouselSlider1(),
                      ),
                      toDoRecent.RecentSearch.isEmpty &&
                              toDo_favorite.favorite.isEmpty
                          ? Container(height: 320, width: 300, child: No_Rep())
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 70, bottom: 200),
                                    child: Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          widget.SearchPage(2);
                                        },
                                        child: Container(
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromRGBO(
                                                      0, 150, 136, 0.5),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            // width: 50,
                                            height: 43,
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
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: SvgPicture.asset(
                                                      "svg_images/search_button.svg"),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: toDo_favorite.favorite.isEmpty
                                          ? false
                                          : true,
                                      child: TextRow(
                                          3, "< مرور همه ", 'ذخیره شده ها ')),
                                  Container(
                                    height: (toDo_favorite.favorite.length <= 3)
                                        ? toDo_favorite.favorite.length * 60
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
                                      visible: Recent_db.RecentSearch.isEmpty
                                          ? false
                                          : true,
                                      child: TextRow(
                                          2, "< مرور همه ", 'جستجو های اخیر')),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2,
                                      right: 2,
                                    ),
                                    child: Container(
                                      height: (Recent_db.RecentSearch.length <=
                                              3)
                                          ? Recent_db.RecentSearch.length * 65
                                          : 3 * 65,
                                      child: GetBuilder<MyController>(
                                        builder: (controller) {
                                          return RecentpageMain();
                                        },
                                      ),
                                    ),
                                  ),
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
    );
  }

  Widget TextRow(int _currentpage, String FirstTitel, secondtitle) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onPageChange(_currentpage);
            },
            child: Container(
              width: 50,
              height: 30,
              child: Text(
                FirstTitel,
                style: TextStyle(
                  fontFamily: fontFamile,
                  fontSize: fontSizeSubTitle,
                  // color: colorPrimary,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Divider(
                height: 1,
                thickness: 0.5,
                color: colorPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            height: 30,
            child: Text(
              secondtitle,
              style: TextStyle(
                fontFamily: fontFamile,
                fontSize: fontSizeSubTitle,
                // color: colorPrimary,
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
