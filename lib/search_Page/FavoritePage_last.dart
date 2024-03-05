import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/util/detailFavoritePage.dart';

class FavoritPage_Me extends StatefulWidget {
  @override
  _FavoritPage_MeState createState() => _FavoritPage_MeState();
}

class _FavoritPage_MeState extends State<FavoritPage_Me> {
  ToDodatabase3 _todoDatabase = ToDodatabase3();
  List<Map<String, String>> dataList = [];

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
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
          title: ListTile(
        trailing: Text('ذخیره شده ها ',
            style: TextStyle(
                fontFamily: 'Yekan Bakh',
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(4, 120, 108, 1))),
      )),
      body: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: _todoDatabase.favorite.length,
            itemBuilder: (context, index) {
              // final item = _todoDatabase.favorite[index];
              return ListTile(
                trailing: Text(
                  _todoDatabase.favorite[index]['name'],
                  style: TextStyle(
                      fontFamily: 'Yekan Bakh',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),

                onTap: () {
                  Get.to(
                      () => DetailFavoirtPage(
                          name: _todoDatabase.favorite[index]['name'],
                          description: _todoDatabase.favorite[index]['description'],
                          footnote:_todoDatabase.favorite[index]['footnote'],
                         
                          initialPageIndex: index),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 400));
                },

                // You can add more Text widgets for other properties if needed
              );
            },
          ),
        ),
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
