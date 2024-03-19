// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/search_Page/RecentPageMain.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePages2.dart';
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
  @override
  void initState() {
    if (_meBox.get('TODORECENT') == null) {
      db.createInitialData();
    }
    db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      TextRow(3, 'مرور همه', 'ذخیره شده ها '),
                      Container(
                        height: 220,
                        child: GetBuilder<MyController>(
                          builder: (controller) {
                            return FavoritPage_menu();
                          },
                        ),
                      ),
                      TextRow(5, 'مرور همه', 'جستجو های اخیر'),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 2,
                          right: 2,
                        ),
                        child: Expanded(
                          child: Container(
                            height: db.favorite.length * 60,
                            child: GetBuilder<MyController>(
                              builder: (controller) {
                                return RecentpageMain();
                              },
                            ),
                          ),
                        ),
                      ),
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
                color: colorPrimary,
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
              color: colorPrimary,
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
