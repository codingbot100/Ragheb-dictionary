// ignore_for_file: unused_field

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/data/sharedPrefernces.dart';

class DetailFavoirtPage extends StatefulWidget {
  final String name;
  final String description;
  final String footnote;
  final int initialPageIndex;

  DetailFavoirtPage({
    super.key,
    required this.name,
    required this.description,
    required this.footnote,
    required this.initialPageIndex,
  });
  @override
  State<DetailFavoirtPage> createState() => _DetailFavoirtPageState();
}

class _DetailFavoirtPageState extends State<DetailFavoirtPage> {
  final _myBox = Hive.box('mybox');
  final _meBox = Hive.box('mybox');

  ToDodatabase3 db = ToDodatabase3();
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();
  var _currentPageIndex = 0;
  bool isFavorite = false;
  SharedPreferencesHelper shareddb = SharedPreferencesHelper();

  @override
  void initState() {
    // if (_meBox.get("TODOfontFamily") == null) {
    //   DB_fontFamily.createInitialData();
    // } else {
    //   DB_fontFamily.loadData();
    // }
    DB_fontFamily.updateDataBase();
    toggleFavorite();
    super.initState();
  }

  void toggleFavorite() {
    setState(() {
      db.favorite.remove(widget.name);
      db.favorite.remove(widget.description);
      db.favorite.remove(widget.footnote);
      db.favorite.remove(widget.initialPageIndex);

      print(
          "remove: ${widget.name}, ${widget.description}, ${widget.footnote}");
    });
  }

  void ToggleRemove(int index) {
    setState(() {
      db.favorite.removeAt(index);
    });
  }

  var fontsClass = fontsize();
  @override
  Widget build(BuildContext context) {
    // final name = widget.name[widget.initialPageIndex];
    // final description = widget.description[widget.initialPageIndex];
    // final footnote = widget.footnote[widget.initialPageIndex];
    // final isFavorite = db.favorite.any((item) => item['name'] == name);
    // db.favorite.any((item) => item['description'] == description);
    // db.favorite.any((item) => item['name'] == footnote);
    return Scaffold(
        backgroundColor: Color(0xFFF5F5DC),
        body: SafeArea(
          child: Column(children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        toggleFavorite();

                        Get.back();
                        db.updateDataBase();
                      });
                    },
                    child: Image.asset('images/new.png'),
                  ),
                  Flexible(
                    child: Container(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          // fontFamily: DB_fontFamily.FontFamily,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(82, 82, 82, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Container(
                      width: double.infinity,
                      child: RichText(
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: widget.description,
                            style: TextStyle(
                              // fontFamily: DB_fontFamily.FontFamily,
                              fontSize: fontsClass.description,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(82, 82, 82, 1),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Visibility(
                      visible: widget.footnote == 'n/a' ? false : true,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(224, 224, 191, 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 15),
                            child: Container(
                              child: Center(
                                child: Flexible(
                                  child: RichText(
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        text: widget.footnote,
                                        style: TextStyle(
                                          // fontFamily: DB_fontFamily.FontFamily,
                                          fontSize: fontsize().footnot,
                                          fontWeight: FontWeight.w900,
                                          color:
                                              Color.fromRGBO(111, 111, 111, 1),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ]),
        ));
  }
}
