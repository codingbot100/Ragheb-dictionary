import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
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
  var image = 'images/open.png';
  fontsize fontSize = fontsize();
  var _currentPageIndex = 0;
  ToDodatabase7 DB_fontFamily = ToDodatabase7();

  bool isFavorite = false;
  String currentDateAndTime = DateTime.now().toString();
  final _meBox = Hive.box('mybox');

  SharedPreferencesHelper2 shareddb = SharedPreferencesHelper2();
  ToDodatabase3 db = new ToDodatabase3();
  ToDodatabaseTime dbTime = new ToDodatabaseTime();

  @override
  void initState() {
    if (_meBox.get("TODOfontFamily") == null) {
      DB_fontFamily.createInitialData();
    } else {
      DB_fontFamily.loadData();
    }
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _pageController.addListener(() {
      setState(() {
        if (_currentPageIndex != _pageController.page!.round()) {
          _currentPageIndex = _pageController.page!.round();
        }
      });
    });

    super.initState();
  }

  void addToList() {
    setState(() {
      Map<String, dynamic> saveItem = {
        "name": widget.name,
        "description": widget.description,
        "footnote": widget.footnote,
        "isFavorite": isFavorite,
      };

      if (isFavorite) {
        // Check if the item already exists in the list
        if (!shareddb.itemList.contains(saveItem)) {
          shareddb.itemList.add(Map.from(saveItem));
          print("add list item");
        }
      } else {
        // Remove the item from the list if it exists
        shareddb.itemList.removeWhere((item) =>
            item["name"] == widget.name &&
            item["description"] == widget.description &&
            item["footnote"] == widget.footnote &&
            item["isFavorite"] == isFavorite);
        print("removed list item");
        print(shareddb.itemList);
      }
    });
  }

  void toggleFavorite() {
    setState(() {
      bool isAlreadyFavorite = db.favorite.any((item) =>
          item['name'] == widget.name &&
          item['description'] == widget.description &&
          item['footnote'] == widget.footnote);

      if (!isAlreadyFavorite) {
        Map<String, dynamic> newItem = {
          'name': widget.name,
          'description': widget.description,
          'footnote': widget.footnote,
          'isFavorite': true,
          'date': DateTime.now(),
        };

        db.favorite.add(newItem);
        dbTime.dateAndTime.add(DateTime.now().toString());
        print(db.favorite);
        // print(dbTime.dateAndTime);
      } else {
        Map<String, dynamic>? itemToRemove;
        for (var item in db.favorite) {
          if (item['name'] == widget.name &&
              item['description'] == widget.description &&
              item['footnote'] == widget.footnote) {
            itemToRemove = item;
            break;
          }
        }

        if (itemToRemove != null) {
          db.favorite.remove(itemToRemove);
          dbTime.dateAndTime.remove(itemToRemove['dateTime']);
          print(
              "Removed from favorites: ${widget.name}, ${widget.description}, ${widget.footnote}");
        }
      }

      // Update the database
      db.updateDataBase();
    });
    print(db.favorite);
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
                                  if (db.favorite.contains(widget.name)) {
                                    image = 'images/new.png';
                                  } else {
                                    image = 'images/open.png';
                                  }
                                  toggleFavorite();
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
                                  fontFamily: DB_fontFamily.fontFamily,
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
                                    text: widget.dataList[index]
                                        ['description']!,
                                    style: TextStyle(
                                      fontFamily: DB_fontFamily.fontFamily,
                                      fontSize: 12,
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
                                    width: isFootnoteNA ? 0 : 500,
                                    height: isFootnoteNA ? 0 : 300,
                                    child: RichText(
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                          text:
                                              widget.dataList[_currentPageIndex]
                                                  ['footnote']!,
                                          style: TextStyle(
                                            fontFamily:
                                                DB_fontFamily.fontFamily,
                                            fontSize: 10,
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

class FavoriteItem {
  late String name;
  late String description;
  late String footnote;
  late bool isFavorite;
  late String dateTime;

  FavoriteItem({
    required this.name,
    required this.description,
    required this.footnote,
    required this.isFavorite,
    required this.dateTime,
  });
}
