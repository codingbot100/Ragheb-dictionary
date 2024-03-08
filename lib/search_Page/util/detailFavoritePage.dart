// ignore_for_file: unused_field

import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
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
  ToDodatabase3 db = ToDodatabase3();
  var _currentPageIndex = 0;
  bool isFavorite = false;
  SharedPreferencesHelper shareddb = SharedPreferencesHelper();

  @override
  void initState() {
    toggleFavorite();
    super.initState();
  }

  void toggleFavorite() {
    setState(() {
      db.favorite.remove({
        'name': widget.name,
        'description': widget.description,
        'footnote': widget.footnote,
      });

      print(
          "remove: ${widget.name}, ${widget.description}, ${widget.footnote}");
    });
  }

  var fontsClass = fontsize();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5DC),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              toggleFavorite();

                              Navigator.pop(context);
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
                                fontFamily: 'YekanBakh',
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 40),
                          child: Container(
                            width: double.infinity,
                            child: RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  text: widget.description,
                                  style: TextStyle(
                                    fontFamily: 'YekanBakh',
                                    fontSize: fontsClass.description,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromRGBO(224, 224, 191, 1)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 15),
                                child: Container(
                                  width: (widget.footnote.isEmpty &&
                                          widget.footnote == 'n/a')
                                      ? 0
                                      : 500,
                                  height: (widget.footnote.isEmpty) ? 0 : 300,
                                  child: RichText(
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        text: widget.footnote,
                                        style: TextStyle(
                                          fontFamily: 'YekanBakh',
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
                        )
                      ],
                    ),
                  ))
                ]))));
  }
}
