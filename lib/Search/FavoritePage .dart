import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Search/DataBase/todo_favorite.dart';
import 'package:ragheb_dictionary/Search/Detail_Page.dart';

class FavoritPage_Me extends StatefulWidget {
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
            Container(
              height: 45,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    shape: RoundedRectangleBorder(side: BorderSide.none),
                    tileColor: Colors.transparent,
                    title: Text(
                      'ذخیره شده ها ',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: db_font.FontFamily,
                          fontWeight: FontWeight.w900),
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
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
