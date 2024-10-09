import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Search/RecentPages/Recent_database.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/ThemeData.dart';
import 'package:ragheb_dictionary/Tools_Menu/ThemeDatabase.dart';

// ignore: must_be_immutable
class RecentPageHomePage extends StatefulWidget {
  int length;
      final void Function() changeIndex;

  RecentPageHomePage({required this.length, required this.changeIndex});

  @override
  _RecentPageHomePageState createState() => _RecentPageHomePageState();
}

class _RecentPageHomePageState extends State<RecentPageHomePage> {
  ToDoDataBaseFont db_font = new ToDoDataBaseFont();
  Recent_Database recentDB = Recent_Database();
  final _meBox = Hive.box('mybox');

  ToDo_FontController db6 = ToDo_FontController();
  ThemeDatabase themeDatabase = ThemeDatabase();
  final thememanger = Get.put(ThemeManager());
  String icons = 'icons/Enable (1).png';
  @override
  void initState() {
    db_font.loadData();
    themeDatabase.loadData();
    if (_meBox.get("TODOLIST") == null || _meBox.get("TODOSlid") == null) {
      recentDB.createInitialData();
      db6.createInitialData();
    } else {
      db6.loadData();
    }
    super.initState();
    thememanger.loadData();
    _initHive();
    widget.length = recentDB.Recent_db.length;
    recentDB.loadData();
  }

  void remove_Favorite(String name, String description, String footnote) {
    setState(() {
      // Find the item with the same name, description, and footnote
      Map<dynamic, dynamic>? itemToRemove;
      for (var item in recentDB.Recent_db) {
        if (item['name'] == name &&
            item['description'] == description &&
            item['footnote'] == footnote) {
          itemToRemove = item;
          break;
        }
      }

      // Remove the item if found
      if (itemToRemove != null) {
        recentDB.Recent_db.remove(itemToRemove);
        recentDB
            .updateDataBase(); // Update the database after removing the item
      }
    });
    Get.back();
  }

  void _initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('mybox');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          // Expanded added here to prevent infinite height issue
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: Divider(
                  thickness: 0.5,
                  color: Color.fromRGBO(0, 150, 136, 0.5),
                ),
              );
            },
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                recentDB.Recent_db.length > 3 ? 3 : recentDB.Recent_db.length,
            itemBuilder: (context, index) {
              int realIndex = recentDB.Recent_db.length > 3
                  ? recentDB.Recent_db.length - 3 + index
                  : index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: isTablet ? 73 : 42,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                            () => DetailPage(
                             
                                  onRemove: remove_Favorite,
                                  page: "mainpage",
                                  name:
                                      "${recentDB.Recent_db[realIndex]['name']}",
                                  description:
                                      "${recentDB.Recent_db[realIndex]['description']}",
                                  footnote:
                                      "${recentDB.Recent_db[realIndex]['footnote']}",
                                  initialPageIndex: realIndex,
                                  dataList: recentDB.Recent_db.map((item) {
                                    return {
                                      'name': item['name'].toString(),
                                      'description':
                                          item['description'].toString(),
                                      'footnote': item['footnote'].toString(),
                                    };
                                  }).toList(),
                                  showFavorite: false,
                                ),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 250));
                        recentDB.updateDataBase();
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, top: 14),
                              child: Text(
                                "${recentDB.Recent_db[realIndex]['name']}",
                                style: TextStyle(
                                  fontSize: isTablet ? 28 : 18,
                                  fontFamily: db_font.FontFamily,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
// Container(
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(25)),
//                     height: isTablet ? 73 : 42,
//                     child: Center(
//                       child: ListTile(
//                         // horizontalTitleGap: BorderSide.strokeAlignInside,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             side: BorderSide(
//                               color: Colors.transparent,
//                             )),
//                         tileColor: Colors.transparent,
//                         title: Text(
//                           item["name"]!,
//                           style: TextStyle(
//                             fontSize: isTablet ? 28 : 18,
//                             fontFamily: db_font.FontFamily,
//                             fontWeight: FontWeight.w900,
//                           ),
//                         ),
//                         onTap: () {
//                           Get.to(
//                             () => DetailPage(
//                               onRemove: remove_Favorite,
//                               page: "mainpage",
//                               name: item['name']!,
//                               description: item['description']!,
//                               footnote: item['footnote']!,
//                               dataList: filteredList,
//                               initialPageIndex: filteredList.indexOf(item),
//                               showFavorite: false,
//                             ),
//                             transition: Transition.fadeIn,
//                             duration: Duration(milliseconds: 400),
//                           );
//                         },
//                       ),
//                     ),
//                   ),