import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/recentData.dart';

import 'package:ragheb_dictionary/search_Page/util/detalilFavorit.dart';
import 'package:ragheb_dictionary/search_Page/util/dialog_box.dart';

class RecentpageSecond extends StatefulWidget {
  @override
  State<RecentpageSecond> createState() => _RecentpageSecondState();
}

class _RecentpageSecondState extends State<RecentpageSecond> {
  final _meBox = Hive.box('mybox');
  ToDodatabase6 db6 = ToDodatabase6();

  ToDoRecent db = ToDoRecent();
  List<Map<String, String>> dataList = [];
  List<String> recentSearches = [];
  bool isShow = false;

  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
    List<String> lines = LineSplitter.split(data).toList();
    List<Map<String, String>> newDataList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> cells = lines[i].split(',');
      Map<String, String> item = {
        "footnote": cells[0],
        "description": cells[1],
        "name": cells[2],
        "favorites": cells[3],
      };
      newDataList.add(item);
    }
    setState(() {
      dataList = newDataList;
    });
  }

  @override
  void initState() {
    if (_meBox.get('TODORECENT') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    loadData();
    db6.createInitialData();
    db6.loadData();
    super.initState();
  }

  List<Map<String, String>> filterDataList() {
    List<Map<String, String>> filteredList = [];
    for (var item in dataList) {
      if (db.favorite.contains(item['name'])) {
        filteredList.add(item);
      }
    }
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filterDataList();
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "جستجوی های اخیر",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      // color: Color.fromRGBO(0, 150, 136, 1)
                    ),
                  )
                ],
              ),
            ),
            secondRow(),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 25, right: 16),
                      child: Divider(),
                    );
                  },
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        height: 40,
                        child: ListTile(
                          shape: RoundedRectangleBorder(side: BorderSide.none),
                          tileColor: Colors.transparent,
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                db.favorite.remove(item["name"]);
                                db.favorite.remove(item["description"]);
                                db.favorite.remove(item["footnote"]);
                                db.favorite.remove(item["isFavorite"]);
                                db.favorite.remove(item["date"]);
                                db.favorite.remove(item["image"]);
                                db.updateDataBase();
                              });
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Color.fromRGBO(0, 150, 136, 1),
                              size: 20,
                            ),
                          ),
                          title: Text(
                            item["name"]!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          onTap: () {
                            Get.to(
                              () => DetailFavoirtMain(
                                name: item['name']!,
                                description: item['description']!,
                                footnote: item['footnote']!,
                                initialPageIndex: dataList.indexOf(item),
                              ),
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class secondRow extends StatefulWidget {
  const secondRow({super.key});

  @override
  State<secondRow> createState() => _secondRowState();
}

class _secondRowState extends State<secondRow> {
  ToDoRecent db = ToDoRecent();

  void removeAll() {
    setState(() {
      db.favorite.clear();
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 9,
        right: 18,
      ),
      child: Expanded(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() async {
                  ShowDilog();
                });
              },
              child: Text("پاک کردن",
                  style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 12,
                    // color: Color.fromRGBO(0, 0, 0, 0.7)
                  )),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Divider(
                thickness: 0.1,
              ),
            ),
            SizedBox(width: 10),
            Text(" جستجو های اخیر",
                style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 12,
                  // color: Color.fromRGBO(0, 0, 0, 0.7)
                ))
          ],
        ),
      ),
    );
  }

  void ShowDilog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogeBox2();
      },
    );
  }
}
