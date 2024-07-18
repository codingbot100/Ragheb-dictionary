// ignore_for_file: must_be_immutable, unnecessary_null_comparison
import 'dart:async';
import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Search/components/secondRow.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/isShow.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class SearchPage extends StatefulWidget {
  bool isShow;
  SearchPage({super.key, required this.isShow});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int selectedPageIndex = 0;
  final _meBox = Hive.box('mybox');
  ToDo_FontController db6 = ToDo_FontController();
  final ShowClass = Get.put(show());
  ToDoRecent RecentData = ToDoRecent();
  late List<Map<String, Widget>> pages;
  final FocusNode _searchFocus = FocusNode();
  List<Map<String, String>> dataList = [];
  List<Map<String, String>> dataList2 = [];
  bool showFouse = false;
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
    try {
      String data = await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
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
          "favorites": row[3].toString()
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

    if (_meBox.get('TODORECENT') == null) {
      RecentData.createInitialData();
    } else {
      RecentData.loadData();
    }

    loadData();
    db6.createInitialData();
    db6.loadData();

    super.initState();
  }

  void addToRecentData(String name, description, footnote) {
    if (name.isNotEmpty) {
      // Check if searchText exists in dataList based on the "name" field
      bool searchTextExists = dataList.any((item) => item['name'] == name);

      if (searchTextExists && !RecentData.RecentSearch.contains(name)) {
        RecentData.RecentSearch.add(name);
        RecentData.updateDataBase();
        print(RecentData.RecentSearch);
      }

      // تنظیم خصوصیات TextField
      _searchController.text = name;
      _searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: _searchController.text.length));
      _searchController.selection =
          TextSelection.collapsed(offset: _searchController.text.length);

      // Filter dataList based on searchText
      filteredList = dataList
          .where((item) =>
              item['name']!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }

    if (RecentData.RecentSearch.length >= 30) {
      RecentData.RecentSearch.removeRange(0, 1);
    }
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
      RecentData.RecentSearch.clear();
      RecentData.updateDataBase();
    });
  }

  void updateSearchControllerValue(String value) {
    setState(() {
      _searchController.text = value;
    });
  }

  List<Map<String, String>> filterDataList() {
    List<Map<String, String>> filteredList = [];
    for (var item in dataList) {
      if (RecentData.RecentSearch.contains(item["name"])) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final filteredList1 = filterDataList();
    double ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenWidth > 600 ? 30 : 15,
                          right: ScreenWidth > 600 ? 30 : 15),
                      child: MouseRegion(
                        onEnter: (event) {
                          //   setState(() {
                          //     Get.find<show>().isShow.value = true;
                          //     print(ShowClass.isShow.value);
                          //   });
                          // },
                          // onExit: (event) {
                          //   setState(() {
                          //     Get.find<show>().isShow.value = false;
                          //     print(ShowClass.isShow.value);
                          //   });
                        },
                        child: Container(
                          height: 45,
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                isShow = hasFocus;
                                widget.isShow = hasFocus;
                                ShowClass.isShow.value =
                                    !ShowClass.isShow.value;
                              });
                            },
                            child: TextField(
                              // focusNode: _searchFocus,
                              // autofocus: showFouse,
                              autofocus: RecentData.RecentSearch.isEmpty
                                  ? true
                                  : false,
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
                                      size: 15,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 10.0, right: 10.0),
                                hintText: "  ...جستجو کنید ",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontFamily: dbFont.FontFamily),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(),
                                ),
                                suffixIcon: IconButton(
                                  isSelected: false,
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    "svg_images/search_new.svg",
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
              Visibility(
                  visible: _searchController.text.isEmpty &&
                          RecentData.RecentSearch.isNotEmpty
                      ? true
                      : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: secondRow(onClear: removeAll),
                  )),
              Visibility(
                  visible: RecentData.RecentSearch.isEmpty &&
                          _searchController.text.isEmpty
                      ? true
                      : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "اخیر هیچ جستجوی انجام نشده است",
                      style: TextStyle(fontFamily: dbFont.FontFamily),
                    ),
                  )),
              Visibility(
                visible: _searchController.text.isEmpty ? true : false,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Divider(
                              thickness: 0.5,
                              color: Color.fromRGBO(0, 150, 136, 1),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: filteredList1.length,
                        itemBuilder: (context, index) {
                          int realIndex = index % filteredList1.length;
                          final item = filteredList1[realIndex];
                          return Container(
                            height: 42,
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: ListTile(
                                leading: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        RecentData.RecentSearch.removeAt(index);
                                        RecentData.updateDataBase();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      size: 20,
                                    ),
                                    color: Color.fromRGBO(0, 150, 136, 1)),
                                horizontalTitleGap:
                                    BorderSide.strokeAlignInside,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                      color: Colors.transparent,
                                    )),
                                tileColor: Colors.transparent,
                                onFocusChange: (e) {
                                  setState(() {});
                                },
                                onTap: () {
                                  Get.to(
                                    () => DetailPage(
                                      onRemove:
                                          (name, descriprion, footnote) {},
                                      page: "mainpage",
                                      name: item['name']!,
                                      description: item['description']!,
                                      footnote: item['footnote']!,
                                      dataList: filteredList1,
                                      initialPageIndex:
                                          filteredList1.indexOf(item),
                                      showFavorite: true,
                                    ),
                                    transition: Transition.fadeIn,
                                    duration: Duration(milliseconds: 500),
                                  );
                                  setState(() {
                                    _searchFocus.unfocus();
                                    _searchController.clear();
                                  });
                                },
                                trailing: Text(
                                  item["name"]!,
                                  style: TextStyle(
                                      fontFamily: dbFont.FontFamily,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
              Visibility(
                visible: _searchController.text.isEmpty ? false : true,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      itemCount: _searchController.text.isEmpty
                          ? dataList.length
                          : filteredList.length,
                      itemBuilder: (context, index) {
                        final item = _searchController.text.isEmpty
                            ? dataList[index]
                            : filteredList[index];
                        return Container(
                          height: 42,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: ListTile(
                              horizontalTitleGap: BorderSide.strokeAlignInside,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  )),
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
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 600),
                                );

                                setState(() {
                                  showFouse = false;
                                  _searchFocus.unfocus();
                                  _searchController.clear();
                                });
                                Timer(
                                    Duration(milliseconds: 100),
                                    () => addToRecentData(
                                        item["name"]!,
                                        item['description']!,
                                        item['footnote']!));
                              },
                            ),
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
      ),
    );
  }
}
