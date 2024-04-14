// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/No_Rep.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/search_Page/RecentPageMain.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePages2.dart';
import 'package:ragheb_dictionary/search_Page/data/data2.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';

class Home extends StatefulWidget {
  final void Function(int) onPageChange;
  const Home({
    Key? key,
    required this.onPageChange,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final MyController _myController = Get.put(MyController());
  final ThemeManager themeManager = Get.find();
  ToDoRecent db = ToDoRecent();
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
  var colorClass = new ColorsClass();
  ToDoRecent toDoRecent = ToDoRecent();
  ToDodatabase3 toDodatabase3 = ToDodatabase3();
  @override
  void initState() {
    themeManager.loadData();
    if (_meBox.get('TODORECENT') == null) {
      db.createInitialData();
    }
    toDoRecent.loadData();
    toDodatabase3.loadData();
    db.loadData();
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
                          ? Icon(Icons.sunny, color: Colors.white)
                          : Icon(
                              Icons.nightlight_rounded,
                            ),
                      color: Colors.black),
                  Text(
                    'فرهنگ لغت راغب',
                    style: TextStyle(
                      fontSize: fontSizeTitle,
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
                        padding: const EdgeInsets.only(bottom: 10.0, top: 25.0),
                        child: Container(
                          child: TextRow(1, 'مرور همه', 'مقالات وبلاگ'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CarouselSlider1(),
                      ),
                      toDoRecent.favorite.isEmpty &&
                              toDodatabase3.favorite.isEmpty
                          ? Container(height: 400, width: 300, child: No_Rep())
                          : Column(
                              children: [
                                TextRow(3, 'مرور همه', 'ذخیره شده ها '),
                                Container(
                                  height: 250,
                                  child: GetBuilder<MyController>(
                                    builder: (controller) {
                                      return FavoritPage_menu(
                                        length: 0,
                                      );
                                    },
                                  ),
                                ),
                                TextRow(2, 'مرور همه', 'جستجو های اخیر'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 2,
                                    right: 2,
                                  ),
                                  child: Expanded(
                                    child: Container(
                                      height: db.favorite.length * 57,
                                      child: GetBuilder<MyController>(
                                        builder: (controller) {
                                          return RecentpageMain();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              widget.onPageChange(_currentpage);
            },
            child: Text(
              FirstTitel,
              style: TextStyle(
                fontFamily: fontFamile,
                fontSize: fontSizeSubTitle,
                // color: colorPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Container(
              child: Divider(
                height: 1,
                thickness: 0.5,
                color: colorPrimary,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            secondtitle,
            style: TextStyle(
              fontFamily: fontFamile,
              fontSize: fontSizeSubTitle,
              // color: colorPrimary,
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
