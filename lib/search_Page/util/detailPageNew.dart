import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/data.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';

import '../../Tools_Menu/CarouselSlider/tools/fonts.dart';

class DetailPage12 extends StatefulWidget {
  final String name;
  final String description;
  final String footnote;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;
  final bool favorites;

  DetailPage12({
    Key? key,
    required this.name,
    required this.description,
    required this.footnote,
    required this.dataList,
    required this.initialPageIndex,
    required this.favorites,
  }) : super(key: key);

  @override
  State<DetailPage12> createState() => _DetailPage12State();
}

class _DetailPage12State extends State<DetailPage12> {
  late PageController _pageController;
  late String image;
  fontsize fontSize = fontsize();
  var _currentPageIndex = 0;
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();

  bool isFavorite = false;
  String currentDateAndTime = DateTime.now().toString();
  final _meBox = Hive.box('mybox');

  SharedPreferencesHelper2 shareddb = SharedPreferencesHelper2();
  ToDodatabase3 db = new ToDodatabase3();
  ToDodatabaseTime dbTime = new ToDodatabaseTime();
  ToDodatabase6 db6 = new ToDodatabase6();

  @override
  void initState() {
    if (_meBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
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
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _pageController.addListener(() {
      setState(() {
        if (_currentPageIndex != _pageController.page!.round()) {
          _currentPageIndex = _pageController.page!.round();
        }
      });
    });
    setState(() {
      image = db.favorite.any((item) => item['name'] == widget.name)
          ? 'images/new.png'
          : 'images/open.png';
    });
    super.initState();
  }

  void addToFavorite() {
    setState(() {
      bool isAlreadyFavorite =
          db.favorite.any((item) => item['name'] == widget.name);
      if (!isAlreadyFavorite) {
        Map<String, dynamic> newItem = {
          'name': widget.name,
          'description': widget.description,
          'footnote': widget.footnote,
          'isFavorite': true,
          'date': DateTime.now(),
          'image':
              'images/new.png', // Updated image for when item is added to favorites
        };
        db.favorite.add(newItem);
        image = 'images/new.png'; // Update image immediately
      } else {
        // Find the item with the same name as widget.name
        Map<String, dynamic>? itemToRemove;
        for (var item in db.favorite) {
          if (item['name'] == widget.name) {
            itemToRemove = item;
            break;
          }
        }
        // Remove the item if found
        if (itemToRemove != null) {
          db.favorite.remove(itemToRemove);
          image = 'images/open.png'; // Update image immediately
        }
      }
      db.updateDataBase();
      updateImage(image); // Call updateImage here
      db.updateImageState(
          widget.name, image); // Update image state in Hive database
    });
  }

  void updateImage(String newImage) {
    setState(() {
      image = newImage;
      db.updateImageState(widget.name, newImage); // Call updateImageState
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isFootnoteNA = widget.dataList.isNotEmpty &&
        widget.dataList[_currentPageIndex]['footnote'] == 'n/a';

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            controller: _pageController,
            itemCount: widget.dataList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InteractiveViewer(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    //   image = 'images/open.png';
                                    // }
                                    addToFavorite();
                                  });
                                },
                                child: Image.asset(
                                  image,
                                  color: Colors.green,
                                )),
                            Flexible(
                              child: Container(
                                child: Text(
                                  widget.dataList[index]['name']!,
                                  style: TextStyle(
                                    fontFamily: DB_fontFamily.FontFamily,
                                    fontSize: db6.name,
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
                                      text: widget.dataList[index]
                                          ['description']!,
                                      style: TextStyle(
                                        fontFamily: DB_fontFamily.FontFamily,
                                        fontSize: db6.Descrption,
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
                                        top: 15,
                                        left: 15,
                                        right: 15,
                                        bottom: 15),
                                    child: Container(
                                      width: isFootnoteNA ? 0 : 500,
                                      height: isFootnoteNA ? 0 : 300,
                                      child: RichText(
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            text: widget
                                                    .dataList[_currentPageIndex]
                                                ['footnote']!,
                                            style: TextStyle(
                                              fontFamily:
                                                  DB_fontFamily.FontFamily,
                                              fontSize: db6.FootNot,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromRGBO(
                                                  111, 111, 111, 1),
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
                    ],
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        height: 70,
        color: Color.fromRGBO(224, 224, 191, 1),
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: () {
                  if (_pageController.page! > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              IconButton(
                onPressed: () {
                  if (_pageController.page! < widget.dataList.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
