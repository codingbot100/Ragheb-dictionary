// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Favorite List App',
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
//   List<String> nameList = [];
//   String description = '';
//   String footnote = '';
//   List<String> favoriteList = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadCSVData();
//   }

//   void loadCSVData() async {
//     try {
//       String data = await rootBundle.loadString('assets/YourOtherCSVFile.csv');
//       List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

//       for (var row in csvTable) {
//         String name = row[2]
//             .toString()
//             .trim(); // Assuming the name is in the third column
//         String rowType = row[0].toString().trim().toLowerCase();

//         if (rowType == 'name') {
//           nameList.add(name);
//         } else if (rowType == 'description') {
//           description = name;
//         } else if (rowType == 'footnote') {
//           footnote = name;
//         }
//       }

//       setState(() {
//         print('Name List: $nameList');
//         print('Description: $description');
//         print('Footnote: $footnote');
//       });
//     } catch (e) {
//       print('Error loading CSV data: $e');
//     }
//   }

//   void addToFavorites(String name) {
//     if (!favoriteList.contains(name)) {
//       setState(() {
//         favoriteList.add(name);
//       });
//     }
//   }

//   void removeFromFavorites(String name) {
//     setState(() {
//       favoriteList.remove(name);
//     });
//   }

//   List<String> filterNames(String query) {
//     return nameList
//         .where((name) => name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Name List'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Description: $description',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: (query) {
//                 setState(() {});
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: () {
//                     searchController.clear();
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filterNames(searchController.text).length,
//               itemBuilder: (context, index) {
//                 String name = filterNames(searchController.text)[index];
//                 return ListTile(
//                   title: Text(name),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailPage(
//                           name: name,
//                           onAddToFavorites: () => addToFavorites(name),
//                           onRemoveFromFavorites: () =>
//                               removeFromFavorites(name),
//                           isFavorite: favoriteList.contains(name),
//                         ),
//                       ),
//                     );
//                   },
//                   trailing: IconButton(
//                     icon: Icon(
//                       favoriteList.contains(name)
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                     ),
//                     onPressed: () {
//                       if (favoriteList.contains(name)) {
//                         removeFromFavorites(name);
//                       } else {
//                         addToFavorites(name);
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Footnote: $footnote',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DetailPage extends StatelessWidget {
//   final String name;
//   final Function onAddToFavorites;
//   final Function onRemoveFromFavorites;
//   final bool isFavorite;

//   const DetailPage({
//     Key? key,
//     required this.name,
//     required this.onAddToFavorites,
//     required this.onRemoveFromFavorites,
//     required this.isFavorite,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail Page'),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//             ),
//             onPressed: () {
//               if (isFavorite) {
//                 onRemoveFromFavorites();
//               } else {
//                 onAddToFavorites();
//               }
//               Navigator.pop(context, isFavorite);
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Name: $name'),
//       ),
//     );
//   }
// }
