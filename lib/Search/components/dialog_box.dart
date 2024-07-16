// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';

class DialogeBox extends StatefulWidget {
  final void Function() onClear;

  DialogeBox({
    Key? key,
    required this.onClear,
  }) : super(key: key);

  @override
  State<DialogeBox> createState() => _DialogeBoxState();
}

class _DialogeBoxState extends State<DialogeBox> {
  ToDoRecent db = ToDoRecent();
  final _meBox = Hive.box('mybox');

  @override
  void initState() {
    if (_meBox.get("TODORECENT") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: AlertDialog(
        elevation: 0.0,
        // icon: Image.asset('icons/cancel 1.png'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Container(
          height: 100,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  child: Image.asset(
                    'icons/cancel 1.png',
                  ),
                ),
                Container(
                  child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "از حذف کامل لیست جستجو های اخیر خویش اطمینان دارید؟",
                      style: TextStyle(
                        fontFamily: 'Yekan',
                        letterSpacing: 1,
                        color: Theme.of(context).textTheme.displayLarge?.color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    Get.back();
                  });
                },
                child: Container(
                  height: 32,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromRGBO(0, 0, 0, 0.2)),
                  child: Center(
                    child: Text('نخیر',
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onClear();
                    Get.back();
                  });
                },
                child: Container(
                  height: 32,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromRGBO(215, 0, 0, 1)),
                  child: Center(
                    child: Text('بلی',
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // void _showSnackBar(BuildContext context, String message,
  //     [Color color = Colors.green]) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Center(
  //         child: Directionality(
  //             textDirection: TextDirection.rtl, child: Text(message)),
  //       ),
  //       backgroundColor: color,
  //     ),
  //   );
  // }

  // void updateTask() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return DialogeBox();
  //     },
  //   );
  //   setState(() {
  //     db.updateDataBase();
  //   });
  // }
}
