// ignore_for_file: must_be_immutable

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

  _copy(String name1, descriprion1) {
    final String combinedText = "$name1\n$descriprion1";
    final data = ClipboardData(text: combinedText);
    Clipboard.setData(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text('محتوا کاپی شد ')),
      ),
    );
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
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: widget.csvData.length,
          itemBuilder: (context, index) {
            var rowData = widget.csvData[index];
            return Padding(
              padding: const EdgeInsets.only(),
              child: InteractiveViewer(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
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
                                      Image.asset(
                                        "images2/${widget.imageList[index % widget.imageList.length]}",
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      // Text overlay
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, bottom: 10, top: 10),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: themeManager.themebo.value
                                            ? Color.fromRGBO(0, 150, 137, 1)
                                            : Color.fromRGBO(82, 82, 82, 1),
                                        fontSize: db6.title_Web,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: DB_fontFamily.FontFamily,
                                      ),
                                      text: rowData[1].toString(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
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
                                          fontSize: db6.main_contant,
                                        ),
                                        text: rowData[0].toString(),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30),
                                  child: Divider(
                                    // color: Color.fromRGBO(147, 147, 147, 1),
                                    thickness: 0.5,
                                  ),
                                ),
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 50, right: 30, left: 30),
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
                                            scale: 1.5,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "اشتراک گذاری",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    DB_fontFamily.FontFamily,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  shareText(
                                                      rowData[1].toString(),
                                                      rowData[0].toString());
                                                },
                                                icon: Image.asset(
                                                  "icons/Vector (5).png",
                                                  scale: 1.5,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: CustomeNavBar(
          dataList: widget.csvData,
          pageController: _pageController,
        ),
      ),
    );
  }
}
