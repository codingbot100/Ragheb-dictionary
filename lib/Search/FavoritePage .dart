import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';
import 'package:ragheb_dictionary/Widgets/Panel.dart';

// ignore: must_be_immutable
class FavoritPage_Me extends StatefulWidget {
  void Function() onchange;
  FavoritPage_Me({Key? key, required this.onchange}) : super(key: key);
  @override
  _FavoritPage_MeState createState() => _FavoritPage_MeState();
}

class _FavoritPage_MeState extends State<FavoritPage_Me> {
  ToDo_favorite _todoDatabase = ToDo_favorite();
  final _meBox = Hive.box('mybox');
  ToDo_FontController db6 = ToDo_FontController();
  ToDoDataBaseFont db_font = ToDoDataBaseFont();

  @override
  void initState() {
    db_font.loadData();
    // _todoDatabase.updateDataBase();
    if (_meBox.get('TODOSlid') == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
    super.initState();

    _todoDatabase.loadData();
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
        _todoDatabase.updateDataBase(); // Update the database after removing the item
        _todoDatabase.updateImageState(
            name, 'icons/Disable (1).png'); // Update image state in Hive
        _todoDatabase.updateDataBase();
      }
    });
    Get.back();
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
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Panel(
                      onChange: () {
                        widget.onchange();
                      },
                      Title: "ذخیره شده ها")),
            ),
            Visibility(
                visible: _todoDatabase.favorite.isEmpty ? true : false,
                child: Text(
                  "هیچ لغت دلخواه اضافه نشده",
                  style: TextStyle(fontFamily: db_font.FontFamily),
                )),
            Expanded(
              child: ListView.separated(
                itemCount: _todoDatabase.favorite.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 45,
                    child: ListTile(
                      horizontalTitleGap: BorderSide.strokeAlignInside,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Colors.transparent,
                          )),
                      tileColor: Colors.transparent,
                      leading: IconButton(
                          onPressed: () {
                            setState(() {
                              _todoDatabase.favorite.removeAt(index);
                              _todoDatabase.updateDataBase();
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 20,
                          ),
                          color: Color.fromRGBO(0, 150, 136, 1)),
                      trailing: Text(
                        "${_todoDatabase.favorite[index]['name']}",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: db_font.FontFamily,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Get.to(
                          () => DetailPage(
                            onRemove: remove_Favorite,
                            page: "favoritePage",
                            name: "${_todoDatabase.favorite[index]['name']}",
                            description:
                                "${_todoDatabase.favorite[index]['description']}",
                            footnote:
                                "${_todoDatabase.favorite[index]['footnote']}",
                            initialPageIndex: index,
                            dataList: _todoDatabase.favorite.map((item) {
                              return {
                                'name': item['name'].toString(),
                                'description': item['description'].toString(),
                                'footnote': item['footnote'].toString(),
                              };
                            }).toList(),
                            showFavorite: false,
                          ),
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 200),
                        );
                        _todoDatabase.updateDataBase();
                        print(_todoDatabase.favorite[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(0, 150, 136, 0.5),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
