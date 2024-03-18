// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';
import 'package:ragheb_dictionary/search_Page/util/detailPageNew.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPageMe extends StatefulWidget {
  bool isShow;
  SearchPageMe({super.key, required this.isShow});

  @override
  State<SearchPageMe> createState() => _SearchPageMeState();
}

class _SearchPageMeState extends State<SearchPageMe> {
  int selectedPageIndex = 0;
  final _meBox = Hive.box('mybox');
  ToDodatabase6 db6 = ToDodatabase6();

  ToDoRecent db = ToDoRecent();
  late List<Map<String, Widget>> pages;
  final FocusNode _searchFocus = FocusNode();
  List<Map<String, String>> dataList = [];
  List<Map<String, String>> filteredList =
      []; // Change the type to Map<String, String>
  ToDoDataBaseFont dbFont = new ToDoDataBaseFont();
  TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  bool isShow = false;
  DateTime now = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  final _meBox2 = Hive.box('mybox2');

  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
    List<String> lines = LineSplitter.split(data).toList();
    List<Map<String, String>> newDataList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> cells = lines[i].split(',');
      Map<String, String> item = {
        "footnote": cells[0],
        "description": cells[1],
        "name": cells[2],
        "favorites": cells[3]
      };
      newDataList.add(item);
    }
    setState(() {
      dataList = newDataList;
    });
  }

  void addtoRecent(String searchText) {
    final item = dataList.firstWhere(
      (element) => element['name'] == searchText,
    );

    if (item != null) {
      // Check if the item is already in favorites
      final bool alreadyInFavorites =
          db.favorite.any((favItem) => favItem['name'] == searchText);
      if (!alreadyInFavorites) {
        // Add the entire map entry to db.favorite
        db.favorite.add(item);
        String currentDateAndTime = DateTime.now().toString();
        db.dateAndTime.add(currentDateAndTime);
        db.updateDataBase();
        print(db.favorite);
      } else {
        print("This data is already in favorites.");
      }
    } else {
      print("This data doesn't exist in the CSV file.");
    }
  }

  @override
  void initState() {
    if (_meBox.get('FontFamily') == null) {
      dbFont.createInitialData();
    } else {
      dbFont.loadData();
    }
    if (_meBox.get('TODORECENT') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    RecentSearchesUtil.loadRecentSearches().then((value) {
      setState(() {
        recentSearches = value;
      });
    });
    loadData();
    db6.createInitialData();
    db6.loadData();
    super.initState();
  }

  //  Expanded(
  //             child: ListView.builder(
  //               itemCount: dataList.length,
  //               itemBuilder: (context, index) {
  //                 final item = dataList[index];
  //                 return Card(
  //                   child: ListTile(
  //                     title: Text(item['name'] ?? ''),
  //                     subtitle: Text(item['description'] ?? ''),
  //                     onTap: () {
  //                       // Handle onTap event if needed
  //                     },
  //                   ),
  //                 );
  //               },
  //             ),
  //           )
  void _onSearch(String searchText) {
    setState(() {
      if (searchText.isNotEmpty) {
        if (!db.favorite.contains(searchText)) {
          db.favorite.add(searchText);
          String currentDateAndTime = DateTime.now().toString();
          db.dateAndTime.add(currentDateAndTime);
          db.updateDataBase();
        }
        _searchController.text = searchText.toString();

        filteredList = dataList
            .where((task) =>
                task['name']!.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
    print(db.favorite);
    if (filteredList.isNotEmpty) {
      _searchController.text = filteredList[0]['name']!;
    }
    if (db.favorite.length >= 30) {
      db.favorite.removeRange(0, 1);
    }
  }

  void remove(int index) {
    setState(() {
      db.favorite.removeAt(index);
      db.dateAndTime.removeAt(index);
      // db.updateDataBase();
    });
  }

  void removeAll() {
    setState(() {
      db.favorite.clear();
    });
  }

  bool convertStringToBool(String value) {
    return value.toLowerCase() == 'false';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 45,
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            isShow = hasFocus;
                            widget.isShow = hasFocus;
                          });
                        },
                        child: TextField(
                          focusNode: _searchFocus,
                          controller: _searchController,
                          cursorColor: Color.fromRGBO(0, 150, 136, 0.5),
                          cursorHeight: 14,
                          cursorOpacityAnimates: true,
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.name,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            fontFamily: dbFont.FontFamily,
                            fontSize: 15,
                            color: Color.fromRGBO(82, 82, 82, 1),
                          ),
                          textAlign: TextAlign.right,
                          // textDirection: TextDirection.rtl,
                          onTap: () {
                            setState(() {
                              _onSearch(_searchController.text);
                              // addtoRecent(_searchController.text);
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              addtoRecent(value);

                              filteredList = dataList
                                  .where((task) => task['name']!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              addtoRecent(value);
                            });
                            if (!recentSearches.contains(value)) {
                              recentSearches.insert(0, value);
                              if (recentSearches.length > 5) {
                                recentSearches.removeLast();
                              }
                              RecentSearchesUtil.saveRecentSearches(
                                  recentSearches);
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  // addtoRecent(_searchController.text);
                                  loadData();
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.only(top: 10.0, right: 10.0),
                            hintText: "  ...جستجو کنید ",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 150, 136, 0.5),
                                fontSize: 10,
                                fontFamily: dbFont.FontFamily),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(0, 150, 136, 0.5),
                              ),
                            ),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _searchController.selection;
                                    db.updateDataBase();
                                    print(db.favorite);
                                    print(db.dateAndTime);
                                  });
                                },
                                child: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isShow ? secondRow() : SizedBox(),
            isShow
                ? ListView.separated(
                    separatorBuilder: ((context, index) {
                      return Divider(
                        thickness: 0.5,
                        color: Color.fromRGBO(0, 150, 136, 0.5),
                      );
                    }),
                    itemCount: db.favorite.length > 5 ? 5 : db.favorite.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Container(
                        height: 37,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.text = db.favorite[index];
                              _searchFocus.unfocus(); // Close the keyboard
                            });
                          },
                          child: ListTile(
                            leading: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    remove(index);
                                  });
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: 17,
                                )),
                            trailing: Text(
                              db.favorite[index],
                              style: TextStyle(
                                  fontFamily: dbFont.FontFamily,
                                  fontSize: db6.RecentSearch,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      );
                    }))
                : SizedBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: ListView.separated(
                    itemCount: _searchController.text.isEmpty
                        ? dataList.length
                        : filteredList.length,
                    itemBuilder: (context, index) {
                      final item = _searchController.text.isEmpty
                          ? dataList[index]
                          : filteredList[index];
                      return Container(
                        height: 37,
                        child: ListTile(
                          trailing: Text(
                            item["name"]!,
                            style: TextStyle(
                                fontFamily: dbFont.FontFamily,
                                fontSize: db6.SearchName,
                                fontWeight: FontWeight.w900),
                          ),
                          onTap: () {
                            Get.to(
                              () => DetailPage12(
                                name: item['name']!,
                                description: item['description']!,
                                footnote: item['footnote']!,
                                favorites:
                                    convertStringToBool(item['favorites']!),
                                dataList: dataList,
                                initialPageIndex: _searchController.text.isEmpty
                                    ? index
                                    : dataList.indexOf(item),
                              ),
                              transition: Transition.cupertino,
                              duration: Duration(milliseconds: 400),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromRGBO(0, 150, 136, 0.5),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class secondRow extends StatefulWidget {
  const secondRow({super.key});

  @override
  State<secondRow> createState() => _secondRowState();
}

class _secondRowState extends State<secondRow> {
  ToDoRecent db = ToDoRecent();

  void removeAll() {
    setState(() {
      db.favorite.clear();
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 9,
        right: 18,
      ),
      child: Expanded(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  // myAlertDialog(context);
                });
              },
              child: Text("پاک کردن",
                  style: TextStyle(
                      fontFamily: 'YekanBakh',
                      fontSize: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.7))),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Divider(
                thickness: 0.5,
              ),
            ),
            SizedBox(width: 10),
            Text("جستجو های اخیر",
                style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.7)))
          ],
        ),
      ),
    );
  }

  Future<void> myAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              // Half of the image's height
              left: 0,
              right: 0,
              child: FractionallySizedBox(
                widthFactor: 1.0, // Take the full width of the container
                alignment: Alignment.topCenter,
                child: Image.asset('icons/cancel 1.png'),
              ),
            ),
            AlertDialog(
              title: Text('Alert'),
              content: Text('This is an alert dialog.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class RecentSearchesUtil {
  static Future<List<String>> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSearches = prefs.getStringList('recentSearches');
    return savedSearches ?? [];
  }

  static Future<void> saveRecentSearches(List<String> searches) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentSearches', searches);
  }
}
