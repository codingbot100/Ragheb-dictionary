import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/search_Page/DetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class search_page extends StatefulWidget {
  @override
  _search_pageState createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  List<Map<String, String>> dataList = [];
  List<Map<String, String>> filteredList = [];
  Set<Map<String, String>> favorites = Set();
  List<Map<String, String>> recentSearches = [];

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
    }

    filteredList = List.from(dataList);
  }

  @override
  void initState() {
    loadData();
    filteredList = List.from(dataList);

    loadFavorites();
    loadRecentSearches();
    filteredList = List.from(dataList);
    super.initState();
  }

  void loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentSearchesList = prefs.getStringList('recentSearches');
    if (recentSearchesList != null) {
      setState(() {
        recentSearches =
            recentSearchesList.map((search) => {'name': search}).toList();
      });
    }
  }

  void saveRecentSearch(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentSearchesList = prefs.getStringList('recentSearches');
    if (recentSearchesList == null) {
      recentSearchesList = [];
    }

    if (!recentSearchesList.contains(search)) {
      recentSearchesList.insert(0, search);
      if (recentSearchesList.length > 5) {
        recentSearchesList.removeLast();
      }
      prefs.setStringList('recentSearches', recentSearchesList);
      loadRecentSearches();
    }
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesList = prefs.getStringList('favorites');

    if (favoritesList != null) {
      setState(() {
        favorites = favoritesList
            .map((favoriteString) => jsonDecode(favoriteString))
            .cast<Map<String, String>>()
            .toSet();
      });
    }
  }

  bool recentSearchesVisible = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(),
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
                        child: SafeArea(
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
                                recentSearchesVisible = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                filteredList = dataList
                                    .where((item) =>
                                        item['name']
                                            ?.toLowerCase()
                                            .contains(value.toLowerCase()) ??
                                        false)
                                    .toList();
                              });
                            },
                            onSubmitted: (value) {
                              saveRecentSearch(value);
                            },
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
                                      filteredList = dataList;
                                      recentSearchesVisible = true;
                                    });
                                  },
                                  child: Icon(Icons.search)),
                            ),
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
                controller: _scrollController,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(0, 150, 136, 0.5),
                    ),
                  );
                },
                itemCount: _searchController.text.isEmpty
                    ? dataList.length
                    : filteredList.length,
                itemBuilder: (context, index) {
                  final item = _searchController.text.isEmpty
                      ? dataList[index]
                      : filteredList[index];
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
                              name: item['name']!,
                              description: item['description']!,
                              footnote: item['footnote']!,
                              onFavoriteChanged: () {},
                              dataList: filteredList,
                              initialPageIndex: index,
                            ),
                          );
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

  void saveFavorite(Map<String, String> favorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

    final String uniqueId =
        '${favorite['description']}-${favorite['footnote']}';

    favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == uniqueId);

    favoritesSet.add(jsonEncode({
      ...favorite,
      'id': uniqueId,
    }));
    prefs.setStringList('favorites', favoritesSet.toList());
  }
}
