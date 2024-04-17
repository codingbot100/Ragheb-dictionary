import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/components/BottomNavBar.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String description;
  final String footnote;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;
  final bool showFavorite;

  DetailPage({
    Key? key,
    required this.name,
    required this.description,
    required this.footnote,
    required this.dataList,
    required this.initialPageIndex,
    required this.showFavorite,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late PageController _pageController;
  late String image;
  var _currentPageIndex = 0;
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();

  bool isFavorite = false;
  String currentDateAndTime = DateTime.now().toString();
  final _meBox = Hive.box('mybox');

  ToDo_favorite db = new ToDo_favorite();
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
        Map newItem = {
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
        Map<dynamic, dynamic>? itemToRemove;
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
        duration: Duration(seconds: 2),
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text('محتوا کاپی شد ')),
      ),
    );
  }

  void shareText(String name, descrption, footnot) {
    String message = "$name\ $descrption\ $footnot";
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
            allowImplicitScrolling: true,
            itemBuilder: (context, index) {
              final name = widget.dataList[index]['name']!;
              final description = widget.dataList[index]['description']!;
              final footnote = widget.dataList[index]['footnote']!;
              final isFavorite =
                  db.favorite.any((item) => item['name'] == name);
              db.favorite.any((item) => item['description'] == description);
              db.favorite.any((item) => item['name'] == footnote);
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InteractiveViewer(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Color(0xFFE0E0BF),
                            //       blurRadius: 10.0,
                            //       offset: Offset(10,
                            //           20),
                            //     ),
                            //    ],
                            ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 20, bottom: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: widget.showFavorite,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addToFavorite(
                                            name, description, footnote);
                                      });
                                    },
                                    icon: Image.asset(
                                      isFavorite
                                          ? 'images/Enable (1).png'
                                          : 'images/Disable (1).png',
                                      color: Colors.green,
                                    )),
                              ),
                              Flexible(
                                child: Container(
                                  child: Text(
                                    widget.dataList[index]['name']!,
                                    style: TextStyle(
                                      fontFamily: DB_fontFamily.FontFamily,
                                      fontSize: 33,
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color, // Use color from i
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                        letterSpacing: 0.3,
                                        fontWeight: FontWeight.w900,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            ?.color, // Use color from iconTheme
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
                                    color: Theme.of(context).bottomAppBarColor,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                        15,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                                textDirection:
                                                    TextDirection.rtl,
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                  text: widget.dataList[
                                                          _currentPageIndex]
                                                      ['footnote']!,
                                                  style: TextStyle(
                                                    fontFamily: DB_fontFamily
                                                        .FontFamily,
                                                    fontSize: db6.FootNot,
                                                    fontWeight: FontWeight.w900,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.color, // Use color from i
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 50, right: 30, left: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _copy(name, description, footnote);
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
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            shareText(
                                                name, description, footnote);
                                          },
                                          icon: Image.asset(
                                            "icons/Vector (5).png",
                                            scale: 1.5,
                                          ))
                                    ],
                                  ),
                                ],
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
      bottomNavigationBar: Container(
        height: 70,
        child: CustomeNavBar(
            dataList: widget.dataList, pageController: _pageController),
      ),
    );
  }
}
