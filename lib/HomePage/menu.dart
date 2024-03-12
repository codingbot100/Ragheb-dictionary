// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePages2.dart';

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

  final myItems = [
    'images2/2.jpg',
    'images2/3.jpg',
    'images2/4.jpg',
    'images2/5.jpg',
  ];
  int myCurrentIndex = 0;
  bool l = false;
  final fontFamile = 'Yekan';
  final fontSizeTitle = 18.0;
  final fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color(0xFFF5F5DC);
  var colortitle;
  var colorClass = new ColorsClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFFF5F5DC),
        elevation: 0,
        actions: [
          Expanded(
            child: ListTile(
              trailing: Text(
                'فرهنگ لغت راغب',
                style: TextStyle(
                  fontFamily: fontFamile,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w900,
                  color: colorPrimary,
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                        child: TextRow(1, 'مرور همه', 'مقالات وبلاگ')),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CarouselSlider1(),
              ),
              TextRow(2, 'مرور همه', 'ذخیره شده ها '),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 188,
                          child: GetBuilder<MyController>(
                            builder: (controller) {
                              return FavoritPage_menu();
                            },
                          ),
                        ),
                        // Other widgets...
                      ],
                    ),
                  ),
                ),
              ),
              TextRow(5, 'مرور همه', 'جستجو های اخیر'),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Expanded(
                  child: Container(
                    height: 250,
                    child: GetBuilder<MyController>(
                      builder: (controller) {
                        return FavoritPage_second();
                      },
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

  Widget TextRow(int _currentpage, String FirstTitel, secondtitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.onPageChange(_currentpage);
                // Get.to((Page));
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
