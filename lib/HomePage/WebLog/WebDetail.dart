import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';

class Web_Log_Detail extends StatefulWidget {
  final String title;
  final String main_Contant;
  final String image;
  const Web_Log_Detail(
      {super.key,
      required this.image,
      required this.title,
      required this.main_Contant});

  @override
  State<Web_Log_Detail> createState() => _Web_Log_DetailState();
}

class _Web_Log_DetailState extends State<Web_Log_Detail> {
  ToDodatabase6 db6 = ToDodatabase6();
  final _meBox = Hive.box('mybox');
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();
  final themeManager = Get.put(ThemeManager());
  @override
  void initState() {
    super.initState();
    if (_meBox.get("FontFamily") == null) {
      DB_fontFamily.createInitialData();
    } else {
      DB_fontFamily.loadData();
    }
    if (_meBox.get("TODOSlid") == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
          backgroundColor: themeManager.themebo == true
              ? Color.fromRGBO(50, 50, 50, 1)
              : Color.fromRGBO(0, 150, 136, 1),
        ),
      ),
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 10, left: 5),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          child: Stack(
                            children: <Widget>[
                              // Background image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  widget.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Text overlay
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: db6.title_Web,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.color, // Use color from iconTheme
                                        fontFamily: DB_fontFamily.FontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: db6.main_contant),
                                    text: widget.main_Contant)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
