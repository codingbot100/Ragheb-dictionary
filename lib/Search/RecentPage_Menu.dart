import 'package:csv/csv.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class RecentPageHomePage extends StatefulWidget {
  const RecentPageHomePage({super.key});

  @override
  State<RecentPageHomePage> createState() => _RecentPageHomePageState();
}

class _RecentPageHomePageState extends State<RecentPageHomePage> {
  ToDoRecent Recent_db = ToDoRecent();
  @override
  void initState() {
    Recent_db.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600;
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        right: 2,
      ),
      child: Container(
          height: (Recent_db.RecentSearch.length <= 3)
              ? isTablet
                  ? Recent_db.RecentSearch.length * 90
                  : Recent_db.RecentSearch.length * 65
              : isTablet
                  ? 3 * 90
                  : 3 * 60,
          child: RecentpageMain()),
    );
  }
}

class RecentpageMain extends StatefulWidget {
  @override
  State<RecentpageMain> createState() => _RecentpageMainState();
}

class _RecentpageMainState extends State<RecentpageMain> {
  final _meBox = Hive.box('mybox');
  ToDo_FontController db6 = ToDo_FontController();
  ToDo_favorite _todoDatabase = ToDo_favorite();

  ToDoDataBaseFont db_font = new ToDoDataBaseFont();
  ToDoRecent RecentData = ToDoRecent();
  List<Map<String, String>> dataList = [];
  List<String> recentSearches = [];
  bool isShow = false;

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

  @override
  void initState() {
    db_font.loadData();
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

  List<Map<String, String>> filterDataList() {
    List<Map<String, String>> filteredList = [];
    for (var item in dataList) {
      if (RecentData.RecentSearch.contains(item['name'])) {
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

  void remove_Favorite(String name, String description, String footnote) {
    setState(() {
      // Find the item with the same name, description, and footnote
      Map<dynamic, dynamic>? itemToRemove;
      for (var item in _todoDatabase.favorite) {
        if (item['name'] == name &&
            item['description'] == description &&
            item['footnote'] == footnote) {
          itemToRemove = item;
          break;
        }
      }

      // Remove the item if found
      if (itemToRemove != null) {
        _todoDatabase.favorite.remove(itemToRemove);
        _todoDatabase
            .updateDataBase(); // Update the database after removing the item
        _todoDatabase.updateImageState(
            name, 'icons/Disable (1).png'); // Update image state in Hive
        _todoDatabase.updateDataBase();
      }
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600;
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
                int realIndex = filteredList.length > 3
                    ? filteredList.length - 3 + index
                    : index;
                final item = filteredList[realIndex];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    height: isTablet ? 73 : 42,
                    child: Center(
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
                            fontSize: isTablet ? 28 : 18,
                            fontFamily: db_font.FontFamily,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        onTap: () {
                          Get.to(
                            () => DetailPage(
                              onRemove: remove_Favorite,
                              page: "mainpage",
                              name: item['name']!,
                              description: item['description']!,
                              footnote: item['footnote']!,
                              dataList: filteredList,
                              initialPageIndex: filteredList.indexOf(item),
                              showFavorite: false,
                            ),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 400),
                          );
                        },
                      ),
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
