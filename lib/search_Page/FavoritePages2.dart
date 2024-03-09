import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/util/detailFavoritePage.dart';

class FavoritPage_menu extends StatefulWidget {
  @override
  _FavoritPage_menuState createState() => _FavoritPage_menuState();
}

class _FavoritPage_menuState extends State<FavoritPage_menu> {
  ToDodatabase3 _todoDatabase = ToDodatabase3();
  final _meBox = Hive.box('mybox');

  @override
  void initState() {
    if (_meBox.get("TODOLIST") == null) {
      _todoDatabase.createInitialData();
    } else {
      _todoDatabase.loadData();
    }
    super.initState();
    _initHive();

    _todoDatabase.createInitialData();
    _todoDatabase.loadData();
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
        backgroundColor: Color(0xFFF5F5DC),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: _todoDatabase.favorite.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5DC),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x12000000),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 2) // changes position of shadow
                                ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 55,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading: Image.asset(
                              'icons/favorite.png',
                              scale: 3,
                            ),
                            title: Text(
                              "${_todoDatabase.favorite[index]['name']}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'YekanBakh'),
                            ),
                            trailing: Text(
                                formatDateTime(
                                    _todoDatabase.favorite[index]['date']),
                                style: TextStyle(color: Colors.grey.shade500)),
                            onTap: () {
                              Get.to(
                                  () => DetailFavoirtPage(
                                      name:
                                          " ${_todoDatabase.favorite[index]['name']}",
                                      description:
                                          "${_todoDatabase.favorite[index]['description']}",
                                      footnote:
                                          "${_todoDatabase.favorite[index]['footnote']}",
                                      initialPageIndex: index),
                                  transition: Transition.cupertino,
                                  duration: Duration(milliseconds: 200));
                              _todoDatabase.updateDataBase();
                            },
                          ),
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
            ],
          ),
        ));
  }
}
