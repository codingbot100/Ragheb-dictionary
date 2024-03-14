import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';

class FavoritPage_second extends StatefulWidget {
  @override
  _FavoritPage_secondState createState() => _FavoritPage_secondState();
}

class _FavoritPage_secondState extends State<FavoritPage_second> {
  ToDoRecent _todoDatabase = ToDoRecent();
  final _meBox = Hive.box('mybox');

  @override
  void initState() {
    if (_meBox.get("TODORECENT") == null) {
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
                    final dateTime =
                        DateTime.parse(_todoDatabase.dateAndTime[index]);
                    final formattedDateTime = formatDateTime(dateTime);
                    return Container(
                      height: 37,
                      child: ListTile(
                        trailing: Text(
                          "${_todoDatabase.favorite[index]}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF525252),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'YekanBakh'),
                        ),
                        leading: Text(formattedDateTime,
                            style: TextStyle(color: Colors.grey.shade500)),
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
