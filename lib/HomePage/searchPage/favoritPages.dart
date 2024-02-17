
// import 'package:flutter/material.dart';
// import 'package:ragheb_dictionary/Prac_Hive/csv2.dart';

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