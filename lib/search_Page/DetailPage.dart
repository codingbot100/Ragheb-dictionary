// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/search_Page.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String footnote;
  final VoidCallback onFavoriteChanged;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;

  DetailPage({
    required this.id,
    required this.name,
    required this.description,
    required this.footnote,
    required this.onFavoriteChanged,
    required this.dataList,
    required this.initialPageIndex,
  }) : super(key: ValueKey(id));

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _meBox = Hive.box("mybox");
  ToDodatabase3 db = ToDodatabase3();
  // final _myBox = Hive.box("description");
  var fontsizeClass = fontsize();
  late PageController _pageController;
  var _currentPageIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _pageController.addListener(() {
      setState(() {
        // Update only if the page index has changed
        if (_currentPageIndex != _pageController.page!.round()) {
          _currentPageIndex = _pageController.page!.round();
          toggleFavorite();
          isFavorite = db.isFavorite(
            widget.dataList[_currentPageIndex]['name']!,
            widget.dataList[_currentPageIndex]['description']!,
            widget.dataList[_currentPageIndex]['footnote']!,
          );
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Hypothetical function to update description
  void updateDescription() {
    setState(() {
      fontsizeClass.description = 16; // Update with your logic
    });
  }

  void toggleFavorite() {
    setState(() {
      db.addToFavorites(widget.name, widget.description, widget.footnote);
      isFavorite = !isFavorite;
    });
  }

  void addToFavorite() {
    setState(() {
      if (db.favorite.contains(widget.name)) {
        db.favorite.remove(widget.name);
        db.favorite.remove(widget.description);
        db.favorite.remove(widget.footnote);
        print("added : " + widget.name);
      } else {
        db.favorite.add(widget.name);
        db.favorite.add(widget.description);
        db.favorite.add(widget.footnote);
        print("remove content: $widget.name");
      }
    });
  }

  var fontsClass = fontsize();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.dataList.length,
          itemBuilder: (context, index) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                child: Container(
                  height: 680,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle favorite button tap
                              setState(() {
                                // addToFavorite();
                                print(db.favorite);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, anim) =>
                                      RotationTransition(
                                    turns: child.key == ValueKey('heart')
                                        ? Tween<double>(begin: 1, end: 0.75)
                                            .animate(anim)
                                        : Tween<double>(begin: 0.75, end: 1)
                                            .animate(anim),
                                    child: FadeTransition(
                                        opacity: anim, child: child),
                                  ),
                                  child: isFavorite
                                      ? Icon(Icons.favorite,
                                          key: const ValueKey('heart'))
                                      : Icon(Icons.favorite_border,
                                          key: const ValueKey('broken_heart')),
                                ),
                                onPressed: () {
                                  // Handle favorite button tap
                                  setState(() {
                                    toggleFavorite();
                                    isFavorite = !isFavorite;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text(
                            widget.dataList[index]['name']!,
                            style: TextStyle(
                              fontFamily: 'YekanBakh',
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(82, 82, 82, 1),
                            ),
                          ),
                        ],
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
                                        fontSize: fontsClass.description,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(82, 82, 82, 1),
                                      ),
                                    ),
                                  ),
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
                                  width: double.infinity,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 15,
                                          right: 15,
                                          bottom: 15),
                                      child: Container(
                                        child: RichText(
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            text: widget.dataList[index]
                                                ['footnote']!,
                                            style: TextStyle(
                                              fontFamily: 'YekanBakh',
                                              fontSize: fontsize().footnot,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromRGBO(
                                                  111, 111, 111, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
                  Get.to(() => search_page(),
                      transition: Transition.leftToRight);
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
                  Get.to(() => search_page());
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
