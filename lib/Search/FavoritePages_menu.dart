// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeData.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class FavoritPage_menu extends StatefulWidget {
  int length;
  FavoritPage_menu({required this.length});

  @override
  _FavoritPage_menuState createState() => _FavoritPage_menuState();
}

class _FavoritPage_menuState extends State<FavoritPage_menu> {
  ToDoDataBaseFont db_font = new ToDoDataBaseFont();
  ToDo_favorite _todoDatabase = ToDo_favorite();
  final _meBox = Hive.box('mybox');
  ToDo_FontController db6 = ToDo_FontController();
  late double borderRadius;
  ThemeDatabase themeDatabase = ThemeDatabase();
  final thememanger = Get.put(ThemeManager());
  String icons = "icons/Vector (1).png";
  @override
  void initState() {
    db_font.loadData();
    themeDatabase.loadData();
    if (_meBox.get("TODOLIST") == null || _meBox.get("TODOSlid") == null) {
      _todoDatabase.createInitialData();
      db6.createInitialData();
    } else {
      _todoDatabase.loadData();
      db6.loadData();
    }
    super.initState();
    thememanger.loadData();
    _initHive();
    widget.length = _todoDatabase.favorite.length;
    _todoDatabase.createInitialData();
    _todoDatabase.loadData();
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

  void _initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('mybox');
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
    return Scaffold(
        body: Column(
      children: [
        // Text('Month'),
        Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _todoDatabase.favorite.length > 3
                ? 3
                : _todoDatabase.favorite.length,
            itemBuilder: (context, index) {
              int realIndex = _todoDatabase.favorite.length > 3
                  ? _todoDatabase.favorite.length - 3 + index
                  : index;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: thememanger.themebo.value != true
                        ? Color.fromRGBO(245, 245, 220, 1)
                        : Colors.transparent,
                    boxShadow: thememanger.themebo.value
                        ? []
                        : [
                            BoxShadow(
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.07),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            )
                          ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      // leading: Image.asset(
                      //   icons,
                      //   scale: 1,
                      // ),
                      leading: IconButton(
                        onPressed: () {
                          remove_Favorite(
                              _todoDatabase.favorite[realIndex]['name'],
                              _todoDatabase.favorite[realIndex]['description'],
                              _todoDatabase.favorite[realIndex]['footnote']);
                        },
                        icon: Image.asset(
                          icons,
                          scale: 1,
                        ),
                      ),
                      title: Text(
                        "${_todoDatabase.favorite[realIndex]['name']}",
                        style: TextStyle(
                          fontFamily: db_font.FontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      trailing: Text(
                          formatDateTime(
                              _todoDatabase.favorite[realIndex]['date']),
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontFamily: db_font.FontFamily)),
                      onTap: () {
                        Get.to(
                            () => DetailPage(
                                  onRemove: remove_Favorite,
                                  page: "favoritePage",
                                  name:
                                      "${_todoDatabase.favorite[index]['name']}",
                                  description:
                                      "${_todoDatabase.favorite[index]['description']}",
                                  footnote:
                                      "${_todoDatabase.favorite[index]['footnote']}",
                                  initialPageIndex: index,
                                  dataList: _todoDatabase.favorite.map((item) {
                                    return {
                                      'name': item['name'].toString(),
                                      'description':
                                          item['description'].toString(),
                                      'footnote': item['footnote'].toString(),
                                    };
                                  }).toList(),
                                  showFavorite: false,
                                ),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 200));
                        _todoDatabase.updateDataBase();
                      },
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
