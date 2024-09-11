// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Search/components/BottomNavBar.dart';
import 'package:share_plus/share_plus.dart';

class Web_Log_Detail extends StatefulWidget {
  final String title;
  final String main_Contant;
  final String image;
  final List imageList;
  final int initialPageIndex; // Add this parameter
  var csvData;
  Web_Log_Detail({
    super.key,
    required this.image,
    required this.title,
    required this.main_Contant,
    required this.csvData,
    required this.imageList,
    required this.initialPageIndex,
  });

  @override
  State<Web_Log_Detail> createState() => _Web_Log_DetailState();
}

class _Web_Log_DetailState extends State<Web_Log_Detail> {
  ToDo_FontController db6 = ToDo_FontController();
  final _meBox = Hive.box('mybox');
  late PageController _pageController;

  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();
  final themeManager = Get.put(ThemeManager());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);

    DB_fontFamily.loadData();

    if (_meBox.get("TODOSlid") == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
  }

  bool isShow = false;

  _copy(String name1, descriprion1) {
    final String combinedText = "$name1\n$descriprion1";
    final data = ClipboardData(text: combinedText);
    Clipboard.setData(data);
    if (!isShow) {
      // Check if snackbar is not already showing
      isShow = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(0, 150, 136, 1),
          duration: Duration(seconds: 2),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              'محتوا کاپی شد ',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: "YekanBakh",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      );

      // Reset isShow after 2 seconds
      Timer(Duration(seconds: 2), () {
        setState(() {
          isShow = false;
        });
      });
    }
  }

  void shareText(
    String name,
    descrption,
  ) {
    String message = "$name\ $descrption";
    Share.share(message);
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Dispose of PageController when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: widget.csvData.length,
          itemBuilder: (context, index) {
            var rowData = widget.csvData[index];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: height * 0.40,
                          width:
                              isTablet ? screenWidth * 0.85 : screenWidth * 1,
                          child: Stack(
                            children: <Widget>[
                              // Background image
                              Image.asset(
                                "web_images/${widget.imageList[index % widget.imageList.length]}",
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              // Text overlay
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: isTablet ? 30 : 15,
                            right: isTablet ? 30 : 15),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: themeManager.themebo.value
                                          ? Color.fromRGBO(0, 150, 137, 1)
                                          : Color.fromRGBO(82, 82, 82, 1),
                                      fontSize: db6.title_Web - 6,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: DB_fontFamily.FontFamily,
                                    ),
                                    text: rowData[1].toString(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.color, // Use color from iconTheme
                                    fontFamily: DB_fontFamily.FontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: db6.main_contant,
                                  ),
                                  text: rowData[0].toString(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Divider(
                                // color: Color.fromRGBO(147, 147, 147, 1),
                                thickness: 0.5,
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 50,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _copy(rowData[1].toString(),
                                            rowData[0].toString());
                                      },
                                      icon: Image.asset(
                                        "icons/Union (1).png",
                                        scale: isTablet ? 1.2 : 1.5,
                                        color: !themeManager.themebo.value
                                            ? Color.fromRGBO(82, 82, 82, 1)
                                            : Color.fromRGBO(153, 153, 153, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            shareText(rowData[1].toString(),
                                                rowData[0].toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text(
                                              "اشتراک گذاری",
                                              style: TextStyle(
                                                fontSize: isTablet ? 15 : 13,
                                                fontFamily:
                                                    DB_fontFamily.FontFamily,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              shareText(rowData[1].toString(),
                                                  rowData[0].toString());
                                            },
                                            icon: Image.asset(
                                              "icons/Vector (5).png",
                                              scale: isTablet ? 1.2 : 1.5,
                                              color: !themeManager.themebo.value
                                                  ? Color.fromRGBO(
                                                      82, 82, 82, 1)
                                                  : Color.fromRGBO(
                                                      153, 153, 153, 1),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: isTablet ? 110 : 87,
        child: CustomeNavBar(
          dataList: widget.csvData,
          pageController: _pageController,
        ),
      ),
    );
  }
}
