import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 35),
                child: Expanded(
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'فرهنگ لغت راغب',
                        style: TextStyle(
                            fontFamily: fontFamile,
                            fontSize: fontSizeTitle,
                            fontWeight: FontWeight.w900,
                            color: colorPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(child: TextRow(' همه  ', 'مقالات وبلاگ')),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: CarouselSlider1()),
              Expanded(child: TextRow('ذخیره شده ها', 'مرور همه')),
              Column(
                children: [
                  Container(
                    width: 350,
                    height: 188,
                    child: MyHomePage_search(),
                  )
                  // Other widgets...
                ],
              ),
              Container(
                width: 350,
                height: 188,
                child: MyHomePage_search(),
              )
            ]))));
  }

  Widget TextRow(String FirstTitel, secondtitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            FirstTitel,
            style: TextStyle(
                fontFamily: fontFamile,
                fontSize: fontSizeSubTitle,
                color: colorPrimary),
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
                color: colorPrimary),
          ),
        ],
      ),
    );
  }
}
