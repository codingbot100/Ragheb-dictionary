import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/components/BottomNavBar.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  final String name;
  final String description;
  final String footnote;
  final List<Map<String, String>> dataList;
  final int initialPageIndex;
  final bool showFavorite;
  final String page;
  void Function(String name, String descriprion, String footnote) onRemove;

  DetailPage({
    Key? key,
    required this.name,
    required this.description,
    required this.footnote,
    required this.dataList,
    required this.initialPageIndex,
    required this.showFavorite,
    required this.page,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late PageController _pageController;
  late String image;
  var _currentPageIndex = 0;
  ToDoDataBaseFont DB_fontFamily = ToDoDataBaseFont();
  final ThemeManager _themeManager = Get.find();
  bool isFavorite = false;
  String currentDateAndTime = DateTime.now().toString();
  final _meBox = Hive.box('mybox');

  ToDo_favorite db = new ToDo_favorite();
  ToDo_FontController FontSize_db = new ToDo_FontController();

  @override
  void initState() {
    if (_meBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    DB_fontFamily.loadData();

    if (_meBox.get("TODOSlid") == null) {
      FontSize_db.createInitialData();
    } else {
      FontSize_db.loadData();
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
        updateImage('icons/Enable (1).png'); // Update image immediately
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
          // widget.onRemove(name, descriprion, footnote);
          updateImage('icons/Disable (1).png'); // Update image immediately
        }
      }
      db.updateDataBase();
      db.updateImageState(name, image); // Update image state in Hive database
    });
  }

  void remove_Favorite(String name, String description, String footnote) {
    setState(() {
      // Find the item with the same name, description, and footnote
      Map<dynamic, dynamic>? itemToRemove;
      for (var item in db.favorite) {
        if (item['name'] == name &&
            item['description'] == description &&
            item['footnote'] == footnote) {
          itemToRemove = item;
          break;
        }
      }

      // Remove the item if found
      if (itemToRemove != null) {
        db.favorite.remove(itemToRemove);
        db.updateDataBase(); // Update the database after removing the item
        db.updateImageState(
            name, 'icons/Disable (1).png'); // Update image state in Hive
        db.updateDataBase();
      }
    });
    Get.back();
  }

  void updateImage(String newImage) {
    setState(() {
      image = newImage;
      db.updateImageState(widget.name, newImage); // Call updateImageState
    });
  }

  bool isShow = false;
  void _copy(String name1, String description1, String footnote1) {
    final String combinedText = "$name1\n$description1\n$footnote1";
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

  void shareText(String name, descrption, footnot) {
    String message = "$name\ $descrption\ $footnot";
    Share.share(message);
  }

  String addNewLines(String text, int linesPerParagraph) {
    // Split the text by spaces to handle each word or punctuation
    List<String> words = text.split(' ');
    StringBuffer buffer = StringBuffer();
    int wordCount = 0;
    int lineCount = 0;

    for (int i = 0; i < words.length; i++) {
      // Append the current word or punctuation to the buffer
      buffer.write(words[i] + ' ');
      wordCount++;

      // Track lines based on approximate word count
      if (wordCount % 8 == 0) {
        lineCount++;
      }

      // Check if a new line is needed
      if (lineCount >= linesPerParagraph &&
          (words[i].endsWith('.') ||
              words[i].endsWith('؟') ||
              words[i].endsWith('!'))) {
        buffer.write('\n'); // Add a new line
        lineCount = 0; // Reset line counter
        wordCount = 0; // Reset word counter
      }
    }

    // Return the formatted text with trimmed whitespace
    return buffer.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600;
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
                padding: EdgeInsets.only(
                  top: isTablet ? 40 : 15,
                  left: isTablet ? 40 : 15,
                  right: isTablet ? 40 : 15,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.page == "mainpage"
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addToFavorite(
                                          name, description, footnote);
                                    });
                                  },
                                  child: Image.asset(
                                    isFavorite
                                        ? 'icons/Enable (1).png'
                                        : 'icons/Disable (1).png',
                                    color: isFavorite
                                        ? Color.fromRGBO(0, 150, 136, 1)
                                        : Color.fromRGBO(111, 111, 111, 1),
                                    scale: isTablet ? 1.7 : 2.5,
                                  ))
                              : widget.page == "favoritePage"
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.onRemove(
                                              name, description, footnote);
                                          remove_Favorite(
                                              name, description, footnote);
                                        });
                                      },
                                      child: Image.asset(
                                        'icons/Enable (1).png',
                                        color: isFavorite
                                            ? Color.fromRGBO(0, 150, 136, 1)
                                            : Color.fromRGBO(111, 111, 111, 1),
                                        scale: isTablet ? 1.7 : 2.5,
                                      ))
                                  : SizedBox(),
                          IntrinsicWidth(
                            stepHeight: 20,
                            child: Text(
                              widget.dataList[index]['name']!,
                              style: TextStyle(
                                  fontFamily: DB_fontFamily.FontFamily,
                                  fontSize: FontSize_db.titile_name,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(0, 150, 136, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Builder(
                              builder: (context) {
                                TextStyle style = TextStyle(
                                  fontFamily: DB_fontFamily.FontFamily,
                                  fontSize: FontSize_db.Descrption,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color,
                                );

                                // Adjust the `linesPerParagraph` parameter as needed
                                String processedText = addNewLines(
                                  widget.dataList[index]['description']!,
                                  4, // Add a new line after approximately 4 lines of text
                                );

                                return RichText(
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    text: processedText,
                                    style: style,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Visibility(
                              visible: widget.dataList[_currentPageIndex]
                                      ['footnote'] !=
                                  'n/a',
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      Theme.of(context).bottomAppBarTheme.color,
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
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.justify,
                                            text: TextSpan(
                                              text: addNewLines(
                                                widget.dataList[
                                                        _currentPageIndex]
                                                    ['footnote']!,
                                                4, // Insert a new line after approximately 4 lines or at punctuation
                                              ),
                                              style: TextStyle(
                                                fontFamily:
                                                    DB_fontFamily.FontFamily,
                                                fontSize: FontSize_db.FootNot,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.6,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 50,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Tooltip(
                                  message: "کاپی شد",
                                  child: IconButton(
                                    onPressed: () {
                                      _copy(name, description, footnote);
                                    },
                                    icon: Image.asset(
                                      "icons/Union (1).png",
                                      scale: isTablet ? 1.2 : 1.5,
                                      color: !_themeManager.themebo.value
                                          ? Color.fromRGBO(82, 82, 82, 1)
                                          : Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        shareText(name, description, footnote);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          "اشتراک گذاری",
                                          style: TextStyle(
                                            fontSize: isTablet ? 15 : 13,
                                            fontFamily:
                                                DB_fontFamily.FontFamily,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          shareText(
                                              name, description, footnote);
                                        },
                                        icon: Image.asset(
                                          "icons/Vector (5).png",
                                          scale: isTablet ? 1.2 : 1.5,
                                          color: !_themeManager.themebo.value
                                              ? Color.fromRGBO(82, 82, 82, 1)
                                              : Color.fromRGBO(
                                                  153, 153, 153, 1),
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
              );
            }),
      ),
      bottomNavigationBar: Container(
        height: isTablet ? 110 : 87,
        child: CustomeNavBar(
            dataList: widget.dataList, pageController: _pageController),
      ),
    );
  }
}
