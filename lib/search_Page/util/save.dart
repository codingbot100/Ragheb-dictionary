// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';
// import 'package:ragheb_dictionary/search_Page/data/database.dart';
// import 'package:ragheb_dictionary/search_Page/search_Page.dart';

// class DetailPage extends StatefulWidget {
//   final String id;
//   final String name;
//   final String description;
//   final String footnote;
//   // bool isFavorite = false;
//   final VoidCallback onFavoriteChanged;
//   final List<Map<String, String>> dataList;
//   final int initialPageIndex;

//   DetailPage({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.footnote,
//     // required this.isFavorite,
//     required this.onFavoriteChanged,
//     required this.dataList,
//     required this.initialPageIndex,
//   }) : super(key: ValueKey(id));

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final _meBox = Hive.box("mybox");
//   ToDodatabase3 db = ToDodatabase3();
//   // final _myBox = Hive.box("description");
//   var fontsizeClass = fontsize();
//   late PageController _pageController;
//   var _currentPageIndex = 0;
//   bool isFavorite = false;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: widget.initialPageIndex);
//     _pageController.addListener(() {
//       setState(() {
//         // Update only if the page index has changed
//         if (_currentPageIndex != _pageController.page!.round()) {
//           _currentPageIndex = _pageController.page!.round();
//           _pageController.addListener(() {
//             setState(() {
//               toggleFavorite();
//             });
//           });
//           // toggleFavorite();

//           // isFavorite = db.isFavorite(
//           //   widget.dataList[_currentPageIndex]['name']!,
//           //   widget.dataList[_currentPageIndex]['description']!,
//           //   widget.dataList[_currentPageIndex]['footnote']!,
//           // );
//         }
//       });
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   // Hypothetical function to update description
//   void updateDescription() {
//     setState(() {
//       fontsizeClass.description = 16; // Update with your logic
//     });
//   }

//   void toggleFavorite() {
//     setState(() {
//       db.addToFavorites(widget.name, widget.description, widget.footnote);
//       isFavorite = !isFavorite;
//     });
//   }

//   var fontsClass = fontsize();
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
//                               // Handle favorite button tap
//                               setState(() {
//                                 toggleFavorite();
//                               });
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               child: IconButton(
//                                 icon: AnimatedSwitcher(
//                                   duration: const Duration(milliseconds: 300),
//                                   transitionBuilder: (child, anim) =>
//                                       RotationTransition(
//                                     turns: child.key == ValueKey('heart')
//                                         ? Tween<double>(begin: 1, end: 0.75)
//                                             .animate(anim)
//                                         : Tween<double>(begin: 0.75, end: 1)
//                                             .animate(anim),
//                                     child: FadeTransition(
//                                         opacity: anim, child: child),
//                                   ),
//                                   child: isFavorite
//                                       ? Icon(Icons.favorite,
//                                           key: const ValueKey('heart'))
//                                       : Icon(Icons.favorite_border,
//                                           key: const ValueKey('broken_heart')),
//                                 ),
//                                 onPressed: () {
//                                   // Handle favorite button tap
//                                   setState(() {
//                                     toggleFavorite();
//                                     isFavorite = !isFavorite;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                           Text(
//                             widget.dataList[_currentPageIndex]['name']!,
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
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 40),
//                                 child: Container(
//                                   width: double.infinity,
//                                   child: RichText(
//                                     textDirection: TextDirection.rtl,
//                                     textAlign: TextAlign.justify,
//                                     text: TextSpan(
//                                       text: widget.dataList[_currentPageIndex]
//                                           ['description']!,
//                                       style: TextStyle(
//                                         fontFamily: 'YekanBakh',
//                                         fontSize: fontsClass.description,
//                                         fontWeight: FontWeight.w900,
//                                         color: Color.fromRGBO(82, 82, 82, 1),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 16),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 40),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       color: Color.fromRGBO(224, 224, 191, 1)),
//                                   width: double.infinity,
//                                   child: Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           top: 15,
//                                           left: 15,
//                                           right: 15,
//                                           bottom: 15),
//                                       child: Container(
//                                         child: RichText(
//                                           textDirection: TextDirection.rtl,
//                                           textAlign: TextAlign.justify,
//                                           text: TextSpan(
//                                             text: widget
//                                                     .dataList[_currentPageIndex]
//                                                 ['footnote']!,
//                                             style: TextStyle(
//                                               fontFamily: 'YekanBakh',
//                                               fontSize: fontsize().footnot,
//                                               fontWeight: FontWeight.w900,
//                                               color: Color.fromRGBO(
//                                                   111, 111, 111, 1),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
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
//               IconButton(
//                 onPressed: () {
//                   Get.to(() => MyHomePage_search(),
//                       transition: Transition.leftToRight);
//                 },
//                 icon: Icon(Icons.arrow_back),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (_pageController.page! > 0) {
//                     _pageController.previousPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   }
//                 },
//                 icon: Icon(Icons.arrow_back_ios),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (_pageController.page! < widget.dataList.length - 1) {
//                     _pageController.nextPage(
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   }
//                 },
//                 icon: Icon(Icons.arrow_forward_ios),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => MyHomePage_search());
//                 },
//                 child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(50)),
//                   child: Icon(Icons.search),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// ///search page 
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:ragheb_dictionary/search_Page/DetailPage.dart';

// main() {
//   runApp(GetMaterialApp(
//     home: MyHomePage_search(),
//   ));
// }

// class MyHomePage_search extends StatefulWidget {
//   @override
//   _MyHomePage_searchState createState() => _MyHomePage_searchState();
// }

// class _MyHomePage_searchState extends State<MyHomePage_search> {
//   List<Map<String, String>> dataList = [];
//   List<Map<String, String>> filteredList = [];
//   Set<Map<String, String>> favorites = Set();
//   List<Map<String, String>> recentSearches = [];

//   @override
//   void initState() {
//     loadData();
//     filteredList = List.from(dataList);
//     super.initState();
//   }

//   TextEditingController _searchController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

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
//       filteredList = List.from(dataList);
//     }
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
//                       height: 68,
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
//                             });
//                           },
//                           onChanged: (value) {
//                             setState(() {
//                               filteredList = dataList
//                                   .where((item) =>
//                                       item['name']
//                                           ?.toLowerCase()
//                                           .contains(value.toLowerCase()) ??
//                                       true)
//                                   .toList();
//                             });
//                           },
//                           onSubmitted: (value) {},
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
//                             suffixIcon: Icon(Icons.search),
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
//                 left: 20,
//                 top: 30,
//                 right: 28,
//               ),
//               child: Flexible(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
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
//             Expanded(
//               child: ListView.separated(
//                 separatorBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: Divider(
//                       thickness: 0.5,
//                       color: Color.fromRGBO(0, 150, 136, 0.5),
//                     ),
//                   );
//                 },
//                 itemCount: filteredList.length,
//                 itemBuilder: (context, index) {
//                   bool isFavorite = favorites.contains(filteredList[index]);
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: Container(
//                       height: 37,
//                       child: ListTile(
//                         trailing: Text(
//                           filteredList[index]['name']!,
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => DetailPage(
//                                 id: filteredList[index]['id'] ?? '', // Replace 'id' with the actual key used in your data
//                                         name: filteredList[index]['name']!,
//                                         description: filteredList[index]
//                                             ['description']!,
//                                         footnote: filteredList[index]
//                                             ['footnote']!,
//                                         onFavoriteChanged: () {
//                                           setState(() {
//                                             if (isFavorite) {
//                                               favorites
//                                                   .remove(filteredList[index]);
//                                             } else {
//                                               favorites
//                                                   .add(filteredList[index]);
//                                             }
//                                           });
//                                         },
//                                         dataList: filteredList,
//                                         initialPageIndex: index,
//                                       )));
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
