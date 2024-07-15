import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class RecentpageMain extends StatefulWidget {
  @override
  State<RecentpageMain> createState() => _RecentpageMainState();
}

class _RecentpageMainState extends State<RecentpageMain> {
  final _meBox = Hive.box('mybox');
  ToDo_FontController db6 = ToDo_FontController();
  ToDoDataBaseFont db_font = new ToDoDataBaseFont();
  ToDoRecent db = ToDoRecent();
  List<Map<String, String>> dataList = [];
  List<String> recentSearches = [];
  bool isShow = false;

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
        "favorites": cells[3],
      };
      newDataList.add(item);
    }
    setState(() {
      dataList = newDataList;
    });
  }

  @override
  void initState() {
    db_font.loadData();
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

  List<Map<String, String>> filterDataList() {
    List<Map<String, String>> filteredList = [];
    for (var item in dataList) {
      if (db.favorite.contains(item['name'])) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // If the date is today, show only the time
      return '${_getFormattedTime(dateTime)} ${_getPeriod(dateTime)}';
    } else if (difference.inDays == 1) {
      // If the date is yesterday, show 'Yesterday'
      return 'دیروز';
    } else {
      // If more than 2 days ago, show the date in the format 'd MMM' (e.g., 3 Jun)
      return '${dateTime.day} ${_getMonthAbbreviation(dateTime.month)}';
    }
  }

  String _getFormattedTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getPeriod(DateTime dateTime) {
    return dateTime.hour < 12 ? "" : "";
  }

  String _getMonthAbbreviation(int month) {
    final monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filterDataList();
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Divider(),
                );
              },
              itemCount: filteredList.length > 3 ? 3 : filteredList.length,
              itemBuilder: (context, index) {
                int realIndex = filteredList.length > 8
                    ? filteredList.length - 8 + index
                    : index;
                final item = filteredList[realIndex];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    height: 42,
                    child: ListTile(
                      // horizontalTitleGap: BorderSide.strokeAlignInside,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.transparent,
                          )),
                      tileColor: Colors.transparent,
                      title: Text(
                        item["name"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: db_font.FontFamily,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          () => DetailPage(
                             onRemove: (name, descriprion, footnote) {
                                
                              },
                            page: "",
                            name: item['name']!,
                            description: item['description']!,
                            footnote: item['footnote']!,
                            dataList: filteredList,
                            initialPageIndex: filteredList.indexOf(item),
                            showFavorite: false,
                          ),
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 200),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
