import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/search_Page/DetailPage.dart';

void main(List<String> args) {
  runApp(GetMaterialApp(
    home: MyHomePage_search(),
  ));
}

class MyHomePage_search extends StatefulWidget {
  @override
  _MyHomePage_searchState createState() => _MyHomePage_searchState();
}

class _MyHomePage_searchState extends State<MyHomePage_search> {
  List<Map<String, String>> dataList = [];
  List<Map<String, String>> filteredList = [];
  Set<Map<String, String>> favorites = Set();
  List<Map<String, String>> recentSearches = [];

  @override
  void initState() {
    loadData();
    filteredList = List.from(dataList);
    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
    List<String> lines = LineSplitter.split(data).toList();

    for (int i = 1; i < lines.length; i++) {
      List<String> cells = lines[i].split(",");
      Map<String, String> item = {
        'footnote': cells[0],
        'description': cells[1],
        'name': cells[2],
      };
      dataList.add(item);
      filteredList = List.from(dataList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 30, right: 15),
                    child: AnimatedContainer(
                      curve: Curves.fastEaseInToSlowEaseOut,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: -10.0,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      duration: Duration(milliseconds: 300),
                      height: 68,
                      child: Center(
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
                            setState(() {
                              filteredList = dataList;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              filteredList = dataList
                                  .where((item) =>
                                      item['name']
                                          ?.toLowerCase()
                                          .contains(value.toLowerCase()) ??
                                      true)
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
                            suffixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 30,
                right: 28,
              ),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
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
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(0, 150, 136, 0.5),
                    ),
                  );
                },
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  bool isFavorite = favorites.contains(filteredList[index]);
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 37,
                      child: ListTile(
                        trailing: Text(
                          filteredList[index]['name']!,
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Get.to(
                              () => DetailPage(
                                    id: '',
                                    name: filteredList[index]['name']!,
                                    description: filteredList[index]
                                        ['description']!,
                                    footnote: filteredList[index]['footnote']!,
                                    onFavoriteChanged: () {
                                      setState(() {
                                        if (isFavorite) {
                                          favorites.remove(filteredList[index]);
                                        } else {
                                          favorites.add(filteredList[index]);
                                        }
                                      });
                                    },
                                    dataList: filteredList,
                                    initialPageIndex: index,
                                  ),
                              transition: Transition.cupertino);
                        },
                      ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}