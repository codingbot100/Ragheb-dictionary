// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/RecentPageSecond.dart';
import 'package:ragheb_dictionary/search_Page/data/isShow.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';
import 'package:ragheb_dictionary/search_Page/util/detailPageNew.dart';

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
  final ShowClass = Get.put(show());
  ToDoRecent db = ToDoRecent();
  late List<Map<String, Widget>> pages;
  final FocusNode _searchFocus = FocusNode();
  List<Map<String, String>> dataList = [];
  List<Map<String, String>> dataList2 = [];

  List<Map<String, String>> filteredList = [];
  List<Map<String, String>> filteredList2 = [];

  ToDoDataBaseFont dbFont = new ToDoDataBaseFont();
  TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  bool isShow = false;
  DateTime now = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  // final _meBox2 = Hive.box('mybox2');

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

  void _performSearch(String searchText) {
    if (searchText.isNotEmpty) {
      // Filter dataList based on searchText
      filteredList2 = dataList
          .where((item) =>
              item['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      // If search text is empty, show all items
      filteredList2 = dataList;
    }

    setState(() {});
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

    loadData();
    db6.createInitialData();
    db6.loadData();

    super.initState();
  }

  void _onSearch(String searchText) {
    if (searchText.isNotEmpty) {
      // Check if searchText exists in dataList based on the "name" field
      bool searchTextExists =
          dataList.any((item) => item['name'] == searchText);

      // If searchText exists in dataList and not in db.favorite, add it to db.favorite
      if (searchTextExists && !db.favorite.contains(searchText)) {
        db.favorite.add(searchText);
        String currentDateAndTime = DateTime.now().toString();
        db.dateAndTime.add(currentDateAndTime);
        db.updateDataBase();
        print(db.favorite);
      }

      // تنظیم خصوصیات TextField
      _searchController.text = searchText;
      _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length));
      _searchController.selection =
          TextSelection.collapsed(offset: _searchController.text.length);

      // Filter dataList based on searchText
      filteredList = dataList
          .where((item) =>
              item['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    if (db.favorite.length >= 30) {
      db.favorite.removeRange(0, 1);
    }
  }

  void remove(int index) {
    setState(() {
      db.favorite.removeAt(index);
      db.dateAndTime.removeAt(index);
      db.updateDataBase();
    });
  }

  void removeAll() {
    setState(() {
      db.favorite.clear();
    });
  }

  void updateSearchControllerValue(String value) {
    setState(() {
      _searchController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: MouseRegion(
                      onEnter: (event) {
                        setState(() {
                          Get.find<show>().isShow.value = true;
                          print(ShowClass.isShow.value);
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          Get.find<show>().isShow.value = false;
                          print(ShowClass.isShow.value);
                        });
                      },
                      child: Container(
                        height: 50,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isShow = hasFocus;
                              widget.isShow = hasFocus;
                              ShowClass.isShow.value = !ShowClass.isShow.value;
                              print(ShowClass.isShow.value);
                            });
                          },
                          child: TextField(
                            focusNode: _searchFocus,
                            controller: _searchController,
                            cursorColor: Color.fromRGBO(0, 150, 136, 0.5),
                            cursorHeight: 14,
                            autocorrect: false,
                            enableSuggestions: false,
                            cursorOpacityAnimates: true,
                            keyboardAppearance: Brightness.dark,
                            keyboardType: TextInputType.name,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontFamily: dbFont.FontFamily,
                              fontSize: 16,
                              // color: Color.fromRGBO(82, 82, 82, 1),
                            ),
                            textAlign: TextAlign.right,
                            onTap: () {
                              setState(() {
                                _onSearch(_searchController.text);
                                // ShowClass.isShow(
                                //     FocusScope.of(context).hasFocus);
                                print(ShowClass.isShow.value);
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                filteredList = dataList
                                    .where((task) => task['name']!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                _performSearch(value);
                              });
                              _onSearch(_searchController.text);
                            },
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: 15,
                                    color: Theme.of(context)
                                        .iconTheme
                                        .color, // Use color from iconTheme
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 10.0, right: 10.0),
                                hintText: "  ...جستجو کنید ",
                                hintStyle: TextStyle(
                                    // color: Color.fromRGBO(0, 150, 136, 0.5),
                                    fontSize: 14,
                                    fontFamily: dbFont.FontFamily),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _searchController.selection;
                                      });
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color, // Use color from iconTheme,)
                                    ))),
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
                ? Visibility(
                    visible: _searchController.text.isEmpty ? true : false,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: db.favorite.length,
                        itemBuilder: (context, index) {
                          String itemName = db.favorite[index];
                          return ListTile(
                            shape:
                                RoundedRectangleBorder(side: BorderSide.none),
                            tileColor: Colors.transparent,
                            onFocusChange: (e) {
                              setState(() {
                                _searchController.text = itemName.toString();
                              });
                            },
                            onTap: () {
                              setState(() {
                                _searchController.text = itemName.toString();
                              });
                            },
                            trailing: Text(
                              db.favorite[index],
                              style: TextStyle(
                                  fontFamily: dbFont.FontFamily,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900),
                            ),
                          );
                        }),
                  )
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
                          shape: RoundedRectangleBorder(side: BorderSide.none),
                          tileColor: Colors.transparent,
                          trailing: Text(
                            item["name"]!,
                            style: TextStyle(
                                fontFamily: dbFont.FontFamily,
                                fontSize: 21,
                                fontWeight: FontWeight.w900),
                          ),
                          onTap: () {
                            Get.to(
                              () => DetailPage12(
                                name: item['name']!,
                                description: item['description']!,
                                footnote: item['footnote']!,
                                dataList: dataList,
                                initialPageIndex: _searchController.text.isEmpty
                                    ? index
                                    : dataList.indexOf(item),
                              ),
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 500),
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
