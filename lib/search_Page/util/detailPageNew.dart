import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/search_Page/data/data.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/util/search_pageMe.dart';

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
  bool isFavorite = false;
  SharedPreferencesHelper2 shareddb = SharedPreferencesHelper2();
  ToDodatabase3 db = new ToDodatabase3();

  @override
  void initState() {
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
      // Check if the current item is already in the list
      bool isAlreadyFavorite = db.favorite.any((item) =>
          item['name'] == widget.name &&
          item['description'] == widget.description &&
          item['footnote'] == widget.footnote);

      if (!isAlreadyFavorite) {
        // Add the item to the list only if it's not already there
        db.favorite.add({
          'name': widget.name,
          'description': widget.description,
          'footnote': widget.footnote,
        });

        print(
            "Added to favorites: ${widget.name}, ${widget.description}, ${widget.footnote}");

        // Save changes to Hive database

        isFavorite = !isFavorite;
      } else {
        db.favorite.remove({
          'name': widget.name,
          'description': widget.description,
          'footnote': widget.footnote,
        });

        print(
            "remove: ${widget.name}, ${widget.description}, ${widget.footnote}");
        db.updateDataBase();
      }
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   child: IconButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           print(shareddb.itemList);
                          //         });
                          //       },
                          //       icon: Icon(Icons.favorite)),
                          // ),
                          // Container(
                          //   child: IconButton(
                          //       onPressed: () {
                          //         setState(() {
                          //           isFavorite = !isFavorite;
                          //         });
                          //       },
                          //       icon: isFavorite
                          //           ? Icon(Icons.favorite)
                          //           : Icon(Icons.favorite_border)),
                          // )
                          InkWell(
                              onTap: () {
                                setState(() {
                                 
                                  toggleFavorite();
                                });
                              },
                              child: Image.asset(
                                db.favorite.contains(widget.name)
                                    ? 'images/new.png'
                                    : "images/open.png",
                                color: Colors.green,
                              )),
                          Flexible(
                            child: Container(
                              child: Text(
                                widget.dataList[index]['name']!,
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
                                    text: widget.dataList[index]
                                        ['description']!,
                                    style: TextStyle(
                                      fontFamily: 'YekanBakh',
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
                                            fontFamily: 'YekanBakh',
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
                  Get.to(() => SearchPageMe());
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
