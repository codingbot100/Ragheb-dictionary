// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';

class DialogeBox2 extends StatefulWidget {
  DialogeBox2({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogeBox2> createState() => _DialogeBox2State();
}

class _DialogeBox2State extends State<DialogeBox2> {
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
        backgroundColor: Color(0xFFF5F5DC),
        content: Container(
          height: 100,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'icons/cancel 1.png',
                  scale: 1.2,
                ),
                Container(
                  height: 40,
                  child: Text(
                    "از حذف کامل لیست جستجو های اخیر خویش اطمینان دارید؟",
                    style: TextStyle(
                      fontFamily: 'Yekan',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 32,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Get.back();
                    });
                  },
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
              Container(
                height: 32,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      db.clearFavorit();
                      db.updateDataBase();
                      Get.back();
                      // _showSnackBar(context, 'لطفاً تمامی فیلدها را پر کنید.',
                      //     Colors.red);
                    });
                  },
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

  void _showSnackBar(BuildContext context, String message,
      [Color color = Colors.green]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Directionality(
              textDirection: TextDirection.rtl, child: Text(message)),
        ),
        backgroundColor: color,
      ),
    );
  }

  void updateTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogeBox2();
      },
    );
  }
}