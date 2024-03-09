import 'package:flutter/widgets.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/CarouselSlider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePages2.dart';

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
    return (Scaffold(
        backgroundColor: Color(0xFFF5F5DC),
        body: SafeArea(
          child: Expanded(
            child: Column(children: [
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 20, bottom: 10),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(child: TextRow('مرور همه', 'مقالات وبلاگ')),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CarouselSlider1()),
              TextRow('مرور همه', 'ذخیره شده ها '),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 188,
                        child: FavoritPage_menu(),
                      )
                      // Other widgets...
                    ],
                  ),
                ),
              ),
              TextRow('مرور همه', 'جستجو های اخیر'),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 188,
                  child: FavoritPage_second(),
                ),
              )
            ]),
          ),
        )));
  }

  Widget TextRow(String FirstTitel, secondtitle) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        height: 20,
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
      ),
    );
  }
}
