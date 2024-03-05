import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ragheb_dictionary/HomePage/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/bottoNavigation.dart';
import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/search_Page/util/detailPageNew.dart';

class SearchPageMe extends StatefulWidget {
  const SearchPageMe({super.key});

  @override
  State<SearchPageMe> createState() => _SearchPageMeState();
}

class _SearchPageMeState extends State<SearchPageMe> {
  int selectedPageIndex = 0;
  late List<Map<String, Widget>> pages;

  List<Map<String, String>> dataList = [];
  List<Map<String, String>> filteredList =
      []; // Change the type to Map<String, String>

  TextEditingController _searchController = TextEditingController();

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
        "name": cells[2]
      };
      newDataList.add(item);
    }
    setState(() {
      dataList = newDataList;
    });
  }

  @override
  void initState() {
    loadData();
    filteredList = List.from(dataList);
    pages = [
      {'Page': Home()},
      {'Page': Home()},
      {'Page': Home()},
      {'Page': Home()},
      {"page": Home()}
    ];
    super.initState();
  }

  // void _selectPage(int index) {
  //   setState(() {
  //     selectedPageIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Color(0xFFF5F5DC),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        height: 70,
        color: Color.fromRGBO(224, 224, 191, 1),
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => MySettingsPage(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 400));
                },
                icon: Icon(Iconsax.setting_24),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => message(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 400));
                },
                icon: Icon(Iconsax.message4),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => bottm(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 400));
                },
                icon: Icon(Iconsax.home),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: 45,
                      child: TextField(
                        controller: _searchController,
                        cursorColor: Color.fromRGBO(0, 150, 136, 0.5),
                        cursorHeight: 14,
                        cursorOpacityAnimates: true,
                        keyboardAppearance: Brightness.dark,
                        keyboardType: TextInputType.name,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontFamily: 'Yekan',
                          fontSize: 15,
                          color: Color.fromRGBO(82, 82, 82, 1),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        onTap: () {
                          setState(() {});
                        },
                        onChanged: (value) {
                          setState(() {
                            filteredList = dataList
                                .where((task) => task['name']!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 15,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.only(top: 10.0, right: 10.0),
                          hintText: "  ...جستجو کنید   ",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(0, 150, 136, 0.5),
                            fontSize: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 150, 136, 0.5),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              child: Icon(Icons.search)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            secondRow(),
            Expanded(
              child: Container(
                  child: ListView.separated(
                itemCount: _searchController.text.isEmpty
                    ? dataList.length
                    : filteredList.length,
                itemBuilder: (context, index) {
                  final item = _searchController.text.isEmpty
                      ? dataList[index]
                      : filteredList[index];
                  return Container(
                    height: 37,
                    child: ListTile(
                      trailing: Text(
                        item["name"]!,
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        Get.to(
                            () => DetailPage12(
                                name: item['name']!,
                                description: item['description']!,
                                footnote: item['footnote']!,
                                dataList: dataList,
                                initialPageIndex: index),
                            transition: Transition.cupertino,
                            duration: Duration(milliseconds: 400));
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
              )),
            )
          ],
        ),
      ),
    );
  }
}

class secondRow extends StatelessWidget {
  const secondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 30,
        right: 28,
      ),
      child: Expanded(
        child: Row(
          children: [
            Text("پاک کردن",
                style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.7))),
            SizedBox(width: 10),
            Expanded(
              child: Divider(
                thickness: 0.5,
              ),
            ),
            SizedBox(width: 10),
            Text("جستجو های اخیر",
                style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.7)))
          ],
        ),
      ),
    );
  }

  // Widget buildNavItem(int index, IconData icon) {
  //   return GestureDetector(
  //     onTap: () => _selectPage,
  //   );
  // }
}
