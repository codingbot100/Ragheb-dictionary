// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Searchable List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Map<String, String>> dataList = [];
//   List<Map<String, String>> filteredList = [];
//   Set<Map<String, String>> favorites = Set();
//   List<Map<String, String>> recentSearches = [];

//   TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//     loadFavorites();
//     loadRecentSearches();
//   }

//   Future<void> loadData() async {
//     String data =
//         await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
//     List<String> lines = LineSplitter.split(data).toList();

//     for (int i = 1; i < lines.length; i++) {
//       List<String> cells = lines[i].split(",");
//       Map<String, String> item = {
//         'footnote': cells[0],
//         'description': cells[1],
//         'name': cells[2],
//       };
//       dataList.add(item);
//     }

//     filteredList = List.from(dataList);
//   }

//   void loadRecentSearches() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? recentSearchesList = prefs.getStringList('recentSearches');
//     if (recentSearchesList != null) {
//       setState(() {
//         recentSearches =
//             recentSearchesList.map((search) => {'name': search}).toList();
//       });
//     }
//   }

//   void saveRecentSearch(String search) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? recentSearchesList = prefs.getStringList('recentSearches');
//     if (recentSearchesList == null) {
//       recentSearchesList = [];
//     }

//     if (!recentSearchesList.contains(search)) {
//       recentSearchesList.insert(0, search);
//       if (recentSearchesList.length > 5) {
//         recentSearchesList.removeLast();
//       }
//       prefs.setStringList('recentSearches', recentSearchesList);
//       loadRecentSearches();
//     }
//   }

//   void loadFavorites() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? favoritesList = prefs.getStringList('favorites');

//     if (favoritesList != null) {
//       setState(() {
//         favorites = favoritesList
//             .map((favoriteString) => jsonDecode(favoriteString))
//             .cast<Map<String, String>>()
//             .toSet();
//       });
//     }
//   }

//   bool recentSearchesVisible = true;

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, top: 30, right: 15),
//                     child: AnimatedContainer(
//                       curve: Curves.fastEaseInToSlowEaseOut,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             spreadRadius: -10.0,
//                             blurRadius: 10.0,
//                             offset: Offset(0.0, 10.0),
//                           )
//                         ],
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(24.0),
//                       ),
//                       duration: Duration(milliseconds: 300),
//                       height: 45,
//                       child: Center(
//                         child: TextField(
//                           controller: _searchController,
//                           cursorColor: Color.fromRGBO(0, 150, 136, 0.5),
//                           cursorHeight: 14,
//                           cursorOpacityAnimates: true,
//                           keyboardAppearance: Brightness.dark,
//                           keyboardType: TextInputType.name,
//                           textAlignVertical: TextAlignVertical.center,
//                           style: TextStyle(
//                             fontFamily: 'Yekan',
//                             fontSize: 15,
//                             color: Color.fromRGBO(82, 82, 82, 1),
//                           ),
//                           textAlign: TextAlign.right,
//                           textDirection: TextDirection.rtl,
//                           onTap: () {
//                             setState(() {
//                               filteredList = dataList;
//                               recentSearchesVisible = true;
//                             });
//                           },
//                           onChanged: (value) {
//                             setState(() {
//                               filteredList = dataList
//                                   .where((item) =>
//                                       item['name']
//                                           ?.toLowerCase()
//                                           .contains(value.toLowerCase()) ??
//                                       false)
//                                   .toList();
//                               recentSearchesVisible = false;
//                             });
//                           },
//                           onSubmitted: (value) {
//                             saveRecentSearch(value);
//                           },
//                           decoration: InputDecoration(
//                             prefixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                 });
//                               },
//                               icon: Icon(
//                                 Icons.clear,
//                                 size: 15,
//                                 color: Color.fromRGBO(0, 0, 0, 0.5),
//                               ),
//                             ),
//                             contentPadding:
//                                 EdgeInsets.only(top: 10.0, right: 10.0),
//                             hintText: "  ...جستجو کنید   ",
//                             hintStyle: TextStyle(
//                               color: Color.fromRGBO(0, 150, 136, 0.5),
//                               fontSize: 10,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(25.0)),
//                               borderSide: BorderSide(
//                                 color: Color.fromRGBO(0, 150, 136, 0.5),
//                               ),
//                             ),
//                             suffixIcon: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _searchController.clear();
//                                   filteredList = dataList;
//                                   recentSearchesVisible = true;
//                                 });
//                               },
//                               child: Image.asset(
//                                 'icons/search.png',
//                                 scale: 1.5,
//                                 color: Color.fromRGBO(0, 150, 136, 1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 20, top: 10, right: 28, bottom: 20),
//               child: Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text("پاک کردن",
//                         style: TextStyle(
//                             fontFamily: 'YekanBakh',
//                             fontSize: 10,
//                             color: Color.fromRGBO(0, 0, 0, 0.7))),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Divider(
//                         thickness: 0.5,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Text("جستجو های اخیر",
//                         style: TextStyle(
//                             fontFamily: 'YekanBakh',
//                             fontSize: 10,
//                             color: Color.fromRGBO(0, 0, 0, 0.7)))
//                   ],
//                 ),
//               ),
//             ),
//             if (recentSearchesVisible)
//               Expanded(
//                 child: ListView.separated(
//                   controller: _scrollController,
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       thickness: 2,
//                       color: Color.fromRGBO(0, 150, 136, 0.5),
//                     );
//                   },
//                   itemCount: recentSearches.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       trailing: Text(recentSearches[index]['name']!),
//                       leading: IconButton(
//                         icon: Icon(Icons.clear),
//                         onPressed: () {
//                           setState(() {
//                             recentSearches.removeAt(index);
//                             SharedPreferences.getInstance().then((prefs) {
//                               prefs.setStringList(
//                                 'recentSearches',
//                                 recentSearches
//                                     .map((search) => search['name']!)
//                                     .toList(),
//                               );
//                             });
//                           });
//                         },
//                       ),
//                       onTap: () {
//                         setState(() {
//                           _searchController.text =
//                               recentSearches[index]['name']!;
//                           filteredList = dataList
//                               .where((item) =>
//                                   item['name']?.toLowerCase().contains(
//                                       recentSearches[index]['name']!
//                                           .toLowerCase()) ??
//                                   false)
//                               .toList();
//                           recentSearchesVisible = false;
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//             if (!recentSearchesVisible)
//               Expanded(
//                 child: ListView.separated(
//                   controller: _scrollController,
//                   separatorBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: Divider(
//                         thickness: 0.5,
//                         color: Color.fromRGBO(0, 150, 136, 0.5),
//                       ),
//                     );
//                   },
//                   itemCount: filteredList.length,
//                   itemBuilder: (context, index) {
//                     bool isFavorite = favorites.contains(filteredList[index]);
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 20, right: 20),
//                       child: Container(
//                         height: 37,
//                         child: ListTile(
//                           trailing: Text(
//                             filteredList[index]['name']!,
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           onTap: () {
//                             Get.to(
//                               () => DetailPage(
//                                 name: filteredList[index]['name']!,
//                                 description: filteredList[index]
//                                     ['description']!,
//                                 footnote: filteredList[index]['footnote']!,
//                                 isFavorite: isFavorite,
//                                 onFavoriteChanged: () {
//                                   setState(() {
//                                     if (isFavorite) {
//                                       favorites.remove(filteredList[index]);
//                                     } else {
//                                       favorites.add(filteredList[index]);
//                                     }
//                                     saveFavorite(filteredList[index]);
//                                   });
//                                 },
//                                 dataList: filteredList,
//                                 initialPageIndex: index,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   void saveFavorite(Map<String, String> favorite) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

//     final String uniqueId =
//         '${favorite['description']}-${favorite['footnote']}';

//     favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == uniqueId);

//     favoritesSet.add(jsonEncode({
//       ...favorite,
//       'id': uniqueId,
//     }));
//     prefs.setStringList('favorites', favoritesSet.toList());
//   }
// }

// class DetailPage extends StatefulWidget {
//   final String name;
//   final String description;
//   final String footnote;
//   final bool isFavorite;
//   final VoidCallback onFavoriteChanged;
//   final List<Map<String, String>> dataList;
//   final int initialPageIndex;

//   DetailPage({
//     required this.name,
//     required this.description,
//     required this.footnote,
//     required this.isFavorite,
//     required this.onFavoriteChanged,
//     required this.dataList,
//     required this.initialPageIndex,
//   }) : super(key: ValueKey(name));

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   late PageController _pageController;
//   var cool;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.initialPageIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: PageView.builder(
//           controller: _pageController,
//           itemCount: widget.dataList.length,
//           itemBuilder: (context, index) {
//             return SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
//                 child: Container(
//                   height: 680,
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 widget.onFavoriteChanged();
//                                 saveFavorite({
//                                   'id': widget.footnote,
//                                   'name': widget.name,
//                                   'description': widget.description,
//                                   'footnote': widget.footnote,
//                                 });
//                                 widget.isFavorite;
//                               });
//                               print("ok");
//                             },
//                             child: AnimatedContainer(
//                                 duration: Duration(milliseconds: 300),
//                                 curve: Curves.easeInOutCubic,
//                                 child: widget.isFavorite
//                                     ? Image.asset(
//                                         'icons/favorite_true.png',
//                                         scale: 1.5,
//                                       )
//                                     : Image.asset(
//                                         'icons/favorite_false.png',
//                                         scale: 1.5,
//                                       )),
//                           ),
//                           Text(
//                             widget.name,
//                             style: TextStyle(
//                               fontFamily: 'YekanBakh',
//                               fontSize: 30,
//                               fontWeight: FontWeight.w900,
//                               color: Color.fromRGBO(82, 82, 82, 1),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                           child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 40),
//                               child: Container(
//                                 width: double.infinity,
//                                 child: RichText(
//                                   textDirection: TextDirection.rtl,
//                                   textAlign: TextAlign.justify,
//                                   text: TextSpan(
//                                     text: widget.dataList[index]
//                                         ['description']!,
//                                     style: TextStyle(
//                                       fontFamily: 'YekanBakh',
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w900,
//                                       color: Color.fromRGBO(82, 82, 82, 1),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 20, right: 20, top: 40),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     color: Color.fromRGBO(224, 224, 191, 1)),
//                                 width: double.infinity,
//                                 child: Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 15,
//                                         left: 15,
//                                         right: 15,
//                                         bottom: 15),
//                                     child: Container(
//                                       child: RichText(
//                                         textDirection: TextDirection.rtl,
//                                         textAlign: TextAlign.justify,
//                                         text: TextSpan(
//                                           text: widget.dataList[index]
//                                               ['footnote']!,
//                                           style: TextStyle(
//                                             fontFamily: 'YekanBakh',
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w900,
//                                             color: Color.fromRGBO(
//                                                 111, 111, 111, 1),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Container(
//                             //     child: Text(
//                             //         widget.dataList[index]['description']!)),
//                             // SizedBox(height: 16),
//                             // Text(
//                             //   'Footnote',
//                             //   style: TextStyle(
//                             //       fontSize: 20, fontWeight: FontWeight.bold),
//                             // ),
//                             // Text(widget.dataList[index]['footnote']!),
//                           ],
//                         ),
//                       ))
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         clipBehavior: Clip.antiAlias,
//         height: 70,
//         color: Color.fromRGBO(224, 224, 191, 1),
//         shape: CircularNotchedRectangle(),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 40, right: 40),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     Get.to(() => MyHomePage(),
//                         transition: Transition.leftToRight);
//                   },
//                   child: Image.asset(
//                     'icons/back_ward.png',
//                     scale: 4,
//                   )),
//               IconButton(
//                   onPressed: () {
//                     if (_pageController.page! > 0) {
//                       _pageController.previousPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   icon: Icon(Icons.arrow_back_ios)),
//               IconButton(
//                   onPressed: () {
//                     if (_pageController.page! < widget.dataList.length - 1) {
//                       _pageController.nextPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     }
//                   },
//                   icon: Icon(Icons.arrow_forward_ios)),
//               GestureDetector(
//                   onTap: () {
//                     Get.to(() => MyHomePage());
//                   },
//                   child: Container(
//                     width: 20,
//                     height: 20,
//                     decoration: BoxDecoration(
//                         color: cool, borderRadius: BorderRadius.circular(50)),
//                     child: Image.asset(
//                       'icons/search.png',
//                       color: Color.fromRGBO(17, 1, 1, 1),
//                       scale: 1,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void saveFavorite(Map<String, String> favorite) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

//     favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == widget.footnote);

//     favoritesSet.add(jsonEncode({
//       ...favorite,
//       'id': widget.footnote,
//     }));
//     prefs.setStringList('favorites', favoritesSet.toList());
//   }
// }
