// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'dart:async';
import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Search/RecentPages/Recent_database.dart';
import 'package:ragheb_dictionary/Search/components/secondRow.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class SearchPage extends StatefulWidget {
  bool isShow;
  final void Function() onIndex;

  SearchPage({super.key, required this.isShow, required this.onIndex});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedPageIndex = 0;
  ToDo_FontController db6 = ToDo_FontController();
  ToDoRecent RecentData = ToDoRecent();
  late List<Map<String, Widget>> pages;
  final FocusNode _searchFocus = FocusNode();
  List<Map<String, dynamic>> dataList = [];
  bool showFouse = false;
  List<Map<String, dynamic>> filteredList = [];
  List<Map<String, dynamic>> filteredList2 = [];

  ToDoDataBaseFont dbFont = new ToDoDataBaseFont();
  TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  bool isShow = false;
  DateTime now = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  Recent_Database recent_database = Recent_Database();

  Future<void> loadData() async {
    try {
      String data =
          await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
      List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

      List<Map<String, String>> newDataList = [];
      for (int i = 1; i < csvTable.length; i++) {
        List<dynamic> row = csvTable[i];
        if (row.length < 4) {
          print("Skipping row $i: not enough columns");
          continue;
        }
        Map<String, String> item = {
          "footnote": row[0].toString(),
          "description": row[1].toString(),
          "name": row[2].toString(),
          // "favorites": row[3].toString()
        };
        newDataList.add(item);
      }

      setState(() {
        dataList = newDataList;
      });
    } catch (e) {
      print("Error loading CSV data: $e");
    }
  }

  void ClearAll() {}
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
    dbFont.loadData();
    recent_database.loadData();

    db6.createInitialData();
    db6.loadData();
    Timer(Duration(milliseconds: 350), () {
      loadData();
    });

    super.initState();
  }

  void addToRecentData(String name, descriprion, footnote) {
    setState(() {
      bool isAlreadyAddedToRecent =
          recent_database.Recent_db.any((item) => item['name'] == name);
      recent_database.Recent_db.any(
          (item) => item['description'] == descriprion);
      recent_database.Recent_db.any((item) => item['footnote'] == footnote);
      if (!isAlreadyAddedToRecent) {
        Map newItem = {
          'name': name,
          'description': descriprion,
          'footnote': footnote,
        };
        recent_database.Recent_db.add(newItem);
      } else {
        // Find the item with the same name as itemName
        Map<dynamic, dynamic>? itemToRemove;
        for (var item in recent_database.Recent_db) {
          if (item['name'] == name) {
            itemToRemove = item;
            break;
          }
        }
        // Remove the item if found
        if (itemToRemove != null) {
          recent_database.Recent_db.remove(itemToRemove);
          // widget.onRemove(name, descriprion, footnote);
        }
      }
      recent_database.updateDataBase();
    });
  }

  void remove(int index) {
    setState(() {
      RecentData.RecentSearch.removeAt(index);
      RecentData.dateAndTime.removeAt(index);
      RecentData.updateDataBase();
    });
  }

  void removeAll() {
    setState(() {
      recent_database.Recent_db.clear();
      recent_database.updateDataBase();
    });
  }

  void updateSearchControllerValue(String value) {
    setState(() {
      _searchController.text = value;
    });
  }

  List<Map<String, dynamic>> filterDataList() {
    List<Map<String, dynamic>> filteredList = [];

    // Filter items based on whether they are in RecentSearch
    for (var item in dataList) {
      if (RecentData.RecentSearch.contains(item["name"])) {
        filteredList.add(item);
      }
    }

    // Sort filteredList based on the order of items in RecentSearch
    filteredList.sort((a, b) {
      int indexA = RecentData.RecentSearch.indexOf(a["name"]);
      int indexB = RecentData.RecentSearch.indexOf(b["name"]);
      return indexA.compareTo(indexB);
    });

    return filteredList;
  }

  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    // final filteredList1 = filterDataList();
    double ScreenWidth = MediaQuery.of(context).size.width;
    // Define breakpoints for different device types
    bool isTablet = ScreenWidth > 600;
    List<Map<String, dynamic>> recentMapList =
        recent_database.Recent_db.map((item) {
      return {
        'name': item['name'],
        'description': item['description'],
        'footnote': item['footnote'],
      };
    }).toList();

    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 25, left: isTablet ? 30 : 15, right: isTablet ? 30 : 15),
              child: Row(
                children: [
                  Expanded(
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          isShow = hasFocus;
                          widget.isShow = hasFocus;
                        });
                      },
                      child: Container(
                        height: isTablet ? 65 : 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromRGBO(0, 150, 136, 1),
                          ),
                          borderRadius:
                              BorderRadius.circular(isTablet ? 30 : 25),
                        ),
                        child: Center(
                          child: TextField(
                            // focusNode: _searchFocus,
                            // autofocus: showFouse,
                            autofocus:
                                RecentData.RecentSearch.isEmpty ? true : false,
                            controller: _searchController,
                            cursorColor: Color.fromRGBO(0, 150, 136, 0.5),
                            cursorHeight: 17,
                            autocorrect: false,
                            enableSuggestions: false,
                            cursorOpacityAnimates: true,
                            keyboardAppearance: Brightness.dark,
                            keyboardType: TextInputType.name,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontFamily: dbFont.FontFamily,
                              fontSize: isTablet ? 26 : 17,
                            ),
                            textAlign: TextAlign.right,
                            onChanged: (value) {
                              setState(() {
                                filteredList = dataList
                                    .where((task) => task['name']!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                                _performSearch(value);
                                showFouse = true;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Visibility(
                                visible: _searchController.text.isEmpty
                                    ? false
                                    : true,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: isTablet ? 27 : 15,
                                    color: Color.fromRGBO(0, 150, 136, 1),
                                  ),
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.only(top: 10.0, right: 10.0),
                              hintText: "  ...جستجو کنید ",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(0, 150, 136, 1),
                                  fontSize: isTablet ? 26 : 17,
                                  fontFamily: dbFont.FontFamily),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Padding(
                                padding:
                                    EdgeInsets.only(right: isTablet ? 10 : 0),
                                child: IconButton(
                                  isSelected: false,
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "svg_images/search_new.svg",
                                    width: isTablet ? 32 : 20,
                                    height: isTablet ? 32 : 20,
                                    colorFilter: ColorFilter.mode(
                                      Color.fromRGBO(111, 111, 111, 1),
                                      BlendMode.srcIn,
                                    ),
                                  ),
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
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: isTablet ? 30 : 10, right: isTablet ? 30 : 20),
                child: Column(
                  children: [
                    Visibility(
                        visible: _searchController.text.isEmpty &&
                                recent_database.Recent_db.isNotEmpty
                            ? true
                            : false,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: isTablet ? 32 : 10,
                              bottom: isTablet ? 25 : 0),
                          child: secondRow(onClear: removeAll),
                        )),
                    Visibility(
                        visible: recent_database.Recent_db.isEmpty &&
                                _searchController.text.isEmpty
                            ? true
                            : false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "اخیر هیچ جستجوی انجام نشده است",
                            style: TextStyle(
                              fontFamily: dbFont.FontFamily,
                              fontSize: isTablet ? 26 : 15,
                            ),
                          ),
                        )),
                    Visibility(
                      visible: _searchController.text.isEmpty ? true : false,
                      child: Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 0),
                              child: Divider(
                                thickness: 0.5,
                                color: Color.fromRGBO(0, 150, 136, 1),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: recent_database
                              .Recent_db.length, // Use dataList length
                          itemBuilder: (context, index) {
                            // int realIndex =
                            //     index % recent_database.Recent_db.length;
                            final item = recentMapList[index];

                            return Container(
                              height: isTablet ? 62 : 42,
                              child: Center(
                                child: myListTile(
                                  () => RemoveIcon(index),
                                  () => onDetail(item, recentMapList, false),
                                  isTablet,
                                  true,
                                  "${item['name']}",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _searchController.text.isEmpty ? false : true,
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.separated(
                            itemCount: _searchController.text.isEmpty
                                ? dataList.length
                                : filteredList.length,
                            itemBuilder: (context, index) {
                              final item = _searchController.text.isEmpty
                                  ? dataList[index]
                                  : filteredList[index];
                              return Container(
                                height: isTablet ? 60 : 40,
                                child: Center(
                                    child: myListTile(
                                  () {},
                                  () => onDetail(item, filteredList, true),
                                  isTablet,
                                  false,
                                  item["name"]!,
                                )),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 0),
                                child: Divider(
                                  thickness: 0.5,
                                  color: Color.fromRGBO(0, 150, 136, 1),
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
            )
          ],
        ),
      ),
    );
  }

  Widget myListTile(void Function() onPress, void Function() Detailpage,
      bool isTablet, isShowIcon, String title) {
    return GestureDetector(
      onTap: Detailpage,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          isShowIcon
              ? Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: IconButton(
                    onPressed: onPress,
                    icon: Icon(Icons.clear,
                        size: isTablet ? 28 : 20,
                        color: Color.fromRGBO(0, 150, 136, 1)),
                  ),
                )
              : SizedBox(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: dbFont.FontFamily,
                    fontSize: isTablet ? 26 : 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void RemoveIcon(int realIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        recent_database.Recent_db.removeAt(realIndex);
        recent_database.updateDataBase();
      });
    });
  }

  void onDetail(final item, dataList, bool isAddToRecentList) {
    // print(
    //   item['footnote'],
    // );
    // print("dataList:$dataList");
    Get.to(
      () => DetailPage(
      
        onRemove: (name, descriprion, footnote) {},
        page: "mainpage",
        name: item['name']!,
        description: item['description']!,
        footnote: item['footnote']!,
        dataList: dataList,
        initialPageIndex: dataList.indexOf(item),
        showFavorite: true,
      ),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 250),
    );
    // print(item['footnote']);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isAddToRecentList) {
        Timer(Duration(seconds: 1), () {
          // add to recent list
          addToRecentData(
              item["name"]!, item['description']!, item['footnote']!);
          setState(() {
            showFouse = false;

            _searchFocus.unfocus();
            _searchController.clear();
          });
        });
      } else {
        setState(() {
          _searchFocus.unfocus();
          _searchController.clear();
        });
      }
    });
  }
}
