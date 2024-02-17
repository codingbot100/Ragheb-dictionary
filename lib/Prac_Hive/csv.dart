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
//     return MaterialApp(
//       title: 'Searchable List',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage_searchPage(),
//     );
//   }
// }

// class MyHomePage_searchPage extends StatefulWidget {
//   @override
//   _MyHomePage_searchPageState createState() => _MyHomePage_searchPageState();
// }

// class _MyHomePage_searchPageState extends State<MyHomePage_searchPage> {
//   List<Map<String, String>> dataList = [];
//   List<Map<String, String>> filteredList = [];
//   Set<Map<String, String>> favorites = Set();
//   List<Map<String, String>> recentSearches = [];

//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//     loadFavorites();
//     loadRecentSearches();
//     // Load favorites when the app starts
//   }

//   Future<void> loadData() async {
//     // Load CSV data
//     String data =
//         await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');

//     // Parse CSV data
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

//     // Initialize filteredList with all items
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

//   void saveFavorite(Map<String, String> favorite) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

//     // Use a unique identifier based on description and footnote
//     final String uniqueId =
//         '${favorite['description']}-${favorite['footnote']}';

//     // Remove the old favorite if it exists
//     favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == uniqueId);

//     favoritesSet.add(jsonEncode({
//       ...favorite,
//       'id': uniqueId,
//     }));
//     prefs.setStringList('favorites', favoritesSet.toList());
//   }

//   bool recentSearchesVisible = true;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       FavoritePage_last(favorites: favorites.toList()),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 10, top: 12, bottom: 10, right: 12),
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
//                               // Show the main list when clicking on the text field
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
//                             contentPadding: EdgeInsets.only(
//                                 top: 10.0, right: 10.0), // Adjust padding
//                             hintText: "  ...جستجو کنید   ",
//                             hintStyle: TextStyle(
//                               color: Color.fromRGBO(0, 150, 136, 0.5),
//                               fontSize: 10,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(25.0),
//                               ),
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
//                                 color: Color.fromRGBO(0, 150, 136, 0.5),
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
//             if (recentSearchesVisible)
//               Expanded(
//                 child: ListView.separated(
//                   controller: _scrollController, // Add controller here
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
//                   controller: _scrollController, // Add controller here
//                   separatorBuilder: (context, index) {
//                     return Divider(
//                       thickness: 0.5,
//                       color: Color.fromRGBO(0, 150, 136, 0.5),
//                     );
//                   },
//                   itemCount: filteredList.length,
//                   itemBuilder: (context, index) {
//                     bool isFavorite = favorites.contains(filteredList[index]);
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: Container(
//                         height: 37,
//                         child: ListTile(
//                           trailing: Text(
//                             filteredList[index]['name']!,
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailPage(
//                                   description: filteredList[index]
//                                       ['description']!,
//                                   footnote: filteredList[index]['footnote']!,
//                                   isFavorite: isFavorite,
//                                   onFavoriteChanged: () {
//                                     setState(() {
//                                       if (isFavorite) {
//                                         favorites.remove(filteredList[index]);
//                                       } else {
//                                         favorites.add(filteredList[index]);
//                                       }
//                                       saveFavorite(filteredList[
//                                           index]); // Save favorite when changed
//                                     });
//                                   },
//                                 ),
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
// }

// class DetailPage extends StatelessWidget {
//   final String description;
//   final String footnote;
//   final bool isFavorite;
//   final VoidCallback onFavoriteChanged;

//   // Add a unique identifier for each favorite item
//   final String uniqueId;

//   DetailPage({
//     required this.description,
//     required this.footnote,
//     required this.isFavorite,
//     required this.onFavoriteChanged,
//   }) : uniqueId =
//             '$description-$footnote'; // Using description and footnote as a unique identifier

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Details'),
//         actions: [
//           IconButton(
//             icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
//             onPressed: () {
//               onFavoriteChanged();
//               saveFavorite({
//                 'id': uniqueId, // Use unique identifier here
//                 'name': description,
//                 'description': description,
//                 'footnote': footnote,
//               });
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Description',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(description),
//             SizedBox(height: 16),
//             Text(
//               'Footnote',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(footnote),
//           ],
//         ),
//       ),
//     );
//   }

//   // Move the saveFavorite function inside the DetailPage class
//   void saveFavorite(Map<String, String> favorite) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Set<String>? favoritesSet = prefs.getStringList('favorites')?.toSet() ?? {};

//     // Remove the old favorite if it exists
//     favoritesSet.removeWhere((fav) => jsonDecode(fav)['id'] == uniqueId);

//     favoritesSet.add(jsonEncode({
//       ...favorite,
//       'id': uniqueId,
//     }));
//     prefs.setStringList('favorites', favoritesSet.toList());
//   }
// }

// class FavoritePage_last extends StatelessWidget {
//   final List<Map<String, String>> favorites;

//   FavoritePage_last({required this.favorites});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Items'),
//       ),
//       body: ListView.builder(
//         itemCount: favorites.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(favorites[index]['name']!),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPage(
//                     description: favorites[index]['description']!,
//                     footnote: favorites[index]['footnote']!,
//                     isFavorite: true,
//                     onFavoriteChanged: () {},
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class bottm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Another Page'),
//       ),
//     );
//   }
// }
