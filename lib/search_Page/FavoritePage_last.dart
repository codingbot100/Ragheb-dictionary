import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';

class FavoritPage_Me extends StatefulWidget {
  @override
  _FavoritPage_MeState createState() => _FavoritPage_MeState();
}

class _FavoritPage_MeState extends State<FavoritPage_Me> {
  ToDodatabase3 _todoDatabase = ToDodatabase3();

  @override
  void initState() {
    super.initState();
    _initHive();
    _todoDatabase.createInitialData();
    _todoDatabase.loadData();
  }

  void _initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('mybox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: _todoDatabase.favorite.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Name: ${_todoDatabase.favorite[index]['name']}"),
              subtitle: Text(
                  "Description: ${_todoDatabase.favorite[index]['description']}"),

              // You can add more Text widgets for other properties if needed
            ),
          );
        },
      ),
    );
  }
}


// Your existing ToDodatabase3 class




// class FavoritPage_Me extends StatefulWidget {
//   @override
//   _FavoritPage_MeState createState() => _FavoritPage_MeState();
// }

// class _FavoritPage_MeState extends State<FavoritPage_Me> {
//   @override
//   Widget build(BuildContext context) {
//     SharedPreferencesHelper db = SharedPreferencesHelper();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List Information'),
//       ),
//       body: ListView.builder(
//         itemCount: db.itemList.length,
//         itemBuilder: (context, index) {
//           String item = db.itemList[index];

//           return ListTile(
//             title: Text(item),
//             trailing: TextButton(
//               onPressed: () {
//                 print(db.itemList);
//               },
//               child: Text('print'),
//             ),
//             // Add more ListTile properties as needed
//           );
//         },
//       ),
//     );
//   }
// }
