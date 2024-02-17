import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/search_Page/favorite_page.dart';
import 'package:ragheb_dictionary/search_Page/search_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String footnote;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;

  DetailPage({
    required this.id,
    required this.name,
    required this.description,
    required this.footnote,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.dataList,
    required this.initialPageIndex,
  }) : super(key: ValueKey(id));

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late PageController _pageController;
  var cool;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                               final FavoriteController controller = Get.find();
              controller.saveFavorite({
                'id': widget.id,
                'name': widget.name,
                'description': widget.description,
                'footnote': widget.footnote,
              });
              Get.to(() => FavoritePage());
                              print("ok");
                            },
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                                child: widget.isFavorite
                                    ? Image.asset(
                                        'icons/favorite_true.png',
                                        scale: 1.5,
                                      )
                                    : Image.asset(
                                        'icons/favorite_false.png',
                                        scale: 1.5,
                                      )),
                          ),
                          Text(
                            widget.name,
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
                                      fontSize: 12,
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
                                            fontSize: 10,
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
                            // Container(
                            //     child: Text(
                            //         widget.dataList[index]['description']!)),
                            // SizedBox(height: 16),
                            // Text(
                            //   'Footnote',
                            //   style: TextStyle(
                            //       fontSize: 20, fontWeight: FontWeight.bold),
                            // ),
                            // Text(widget.dataList[index]['footnote']!),
                          ],
                        ),
                      ))
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
              GestureDetector(
                  onTap: () {
                    Get.to(() => MyHomePage_search(),
                        transition: Transition.leftToRight);
                  },
                  child: Image.asset(
                    'icons/back_ward.png',
                    scale: 4,
                  )),
              IconButton(
                  onPressed: () {
                    if (_pageController.page! > 0) {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              IconButton(
                  onPressed: () {
                    if (_pageController.page! < widget.dataList.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios)),
              GestureDetector(
                  onTap: () {
                    Get.to(() => MyHomePage_search());
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: cool, borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                      'icons/search.png',
                      color: Color.fromRGBO(17, 1, 1, 1),
                      scale: 1,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void saveFavorite(Map<String, String> favorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

    favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == widget.footnote);

    favoritesSet.add(jsonEncode({
      ...favorite,
      'id': widget.footnote,
    }));
    prefs.setStringList('favorites', favoritesSet.toList());
  }
}
