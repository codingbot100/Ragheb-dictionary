import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/util/detailFavoritePage.dart';

class FavoritPage_Me extends StatefulWidget {
  @override
  _FavoritPage_MeState createState() => _FavoritPage_MeState();
}

class _FavoritPage_MeState extends State<FavoritPage_Me> {
  ToDodatabase3 _todoDatabase = ToDodatabase3();
  final _meBox = Hive.box('mybox');
  ToDodatabase6 db6 = ToDodatabase6();

  @override
  void initState() {
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
        backgroundColor: Color(0xFFF5F5DC),
        body: SafeArea(
          child: Column(
            children: [
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    title: Text(
                      'ذخیره شده ها ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                    ),
                  )),
              Expanded(
                child: ListView.separated(
                  itemCount: _todoDatabase.favorite.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 37,
                      child: ListTile(
                        leading: Text(
                          formatDateTime(_todoDatabase.favorite[index]['date']),
                        ),
                        trailing: Text(
                          "${_todoDatabase.favorite[index]['name']}",
                          style: TextStyle(
                              fontSize: db6.SearchName,
                              fontWeight: FontWeight.w600),
                        ),
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
                              duration: Duration(milliseconds: 400));
                          _todoDatabase.updateDataBase();
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
            ],
          ),
        ));
  }
}
