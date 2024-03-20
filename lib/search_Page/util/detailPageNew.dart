import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/data.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:share_plus/share_plus.dart';

import '../../Tools_Menu/CarouselSlider/tools/fonts.dart';

class DetailPage12 extends StatefulWidget {
  final String name;
  final String description;
  final String footnote;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;

  DetailPage12({
    Key? key,
    required this.name,
    required this.description,
    required this.footnote,
    required this.dataList,
    required this.initialPageIndex,
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
  //  final String combinedText = "$widget.footnote\n$widget.footnote\n$widget.footnote";

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
          ? 'images/Enable (1).png'
          : 'images/Disable (1).png';
    });
    super.initState();
  }

  void addToFavorite(String name, descriprion, footnote) {
    setState(() {
      bool isAlreadyFavorite = db.favorite.any((item) => item['name'] == name);
      db.favorite.any((item) => item['description'] == descriprion);
      db.favorite.any((item) => item['footnote'] == footnote);
      if (!isAlreadyFavorite) {
        Map<String, dynamic> newItem = {
          'name': name,
          'description': descriprion,
          'footnote': footnote,
          'isFavorite': true,
          'date': DateTime.now(),
          'image': 'images/new.png',
        };
        db.favorite.add(newItem);
        updateImage('images/Enable (1).png'); // Update image immediately
      } else {
        // Find the item with the same name as itemName
        Map<String, dynamic>? itemToRemove;
        for (var item in db.favorite) {
          if (item['name'] == name) {
            itemToRemove = item;
            break;
          }
        }
        // Remove the item if found
        if (itemToRemove != null) {
          db.favorite.remove(itemToRemove);
          updateImage('images/Disable (1).png'); // Update image immediately
        }
      }
      db.updateDataBase();
      db.updateImageState(name, image); // Update image state in Hive database
    });
  }

  void updateImage(String newImage) {
    setState(() {
      image = newImage;
      db.updateImageState(widget.name, newImage); // Call updateImageState
    });
  }

  _copy(String name1, descriprion1, footnote1) {
    final String combinedText = "$name1\n$descriprion1\n$footnote1";
    final data = ClipboardData(text: combinedText);
    Clipboard.setData(data);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text('متن کاپی شد ')),
      ),
    );
  }

  void shareText(String name, descrption, footnot) {
    String message = "Name: $name\nDescription: $descrption\nFootnot: $footnot";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: widget.dataList.length,
            itemBuilder: (context, index) {
              final name = widget.dataList[index]['name']!;
              final description = widget.dataList[index]['description']!;
              final footnote = widget.dataList[index]['footnote']!;
              final isFavorite =
                  db.favorite.any((item) => item['name'] == name);
              db.favorite.any((item) => item['description'] == description);
              db.favorite.any((item) => item['name'] == footnote);
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InteractiveViewer(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    addToFavorite(name, description, footnote);
                                  });
                                },
                                child: Image.asset(
                                  isFavorite
                                      ? 'images/Enable (1).png'
                                      : 'images/Disable (1).png',
                                  scale: 2.5,
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
                              child: Visibility(
                                visible: widget.dataList[_currentPageIndex]
                                        ['footnote'] !=
                                    'n/a',
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromRGBO(224, 224, 191, 1)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15,
                                      ),
                                      child: Container(
                                        child: Expanded(
                                          child: RichText(
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.justify,
                                              text: TextSpan(
                                                text: widget.dataList[
                                                        _currentPageIndex]
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
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _copy(name, description, footnote);
                                    },
                                    icon: Icon(Icons.copy)),
                                IconButton(
                                    onPressed: () async {
                                      shareText(name, description, footnote);
                                    },
                                    icon: Icon(Icons.share))
                              ],
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
              Container(
                width: 20,
                height: 50,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'icons/back.png',
                    scale: 4.5,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_pageController.page! > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  }
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 23,
                  color: Color.fromRGBO(111, 111, 111, 1),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_pageController.page! < widget.dataList.length - 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  }
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 23,
                  color: Color.fromRGBO(111, 111, 111, 1),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 20,
                  height: 30,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: Color.fromRGBO(111, 111, 111, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
