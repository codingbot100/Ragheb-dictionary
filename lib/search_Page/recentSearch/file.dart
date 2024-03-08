// import 'package:flutter/material.dart';
// import 'package:ragheb_dictionary/search_Page/recentSearch/RecentDatabase.dart';

// main() {
//   runApp(MaterialApp(home: SearchPage()));
// }

// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   final RecentSearchManager _recentSearchManager = RecentSearchManager();
//   bool showRecentSearches = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           onTap: () {
//             setState(() {
//               showRecentSearches = true;
//             });
//           },
//           child: TextField(
//             controller: _searchController,
//             onChanged: (query) {
//               // Handle search input changes
//             },
//             onSubmitted: (query) {
//               // Handle search submission
//               _recentSearchManager.addRecentSearch(query);
//               setState(() {
//                 showRecentSearches = false;
//               });
//             },
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   _searchController.clear();
//                 },
//                 icon: Icon(Icons.clear),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: showRecentSearches
//           ? FutureBuilder<List<String>>(
//               future: _recentSearchManager.getRecentSearches(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   List<String> recentSearches = snapshot.data ?? [];
//                   return ListView.builder(
//                     itemCount: recentSearches.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(recentSearches[index]),
//                         onTap: () {
//                           // Handle tapping on a recent search item
//                           _searchController.text = recentSearches[index];
//                           setState(() {
//                             showRecentSearches = false;
//                           });
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             )
//           : Container(),
//     );
//   }
// }
