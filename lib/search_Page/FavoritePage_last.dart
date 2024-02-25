import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';

class FavoritPage_Me extends StatefulWidget {
  const FavoritPage_Me({super.key});

  @override
  State<FavoritPage_Me> createState() => _FavoritPage_MeState();
}

class _FavoritPage_MeState extends State<FavoritPage_Me> {
  final _myBox = Hive.box('mybox');
  ToDodatabase3 db = ToDodatabase3();

  @override
  void initState() {
    setState(() {
      if (_myBox.get("TODOLIST2") == null) {
        db.createInitialData();
      } else {
        db.loadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Text(
              " ذخیره شده ها",
              style: TextStyle(
                color: Color(0xFF009688),
                fontSize: 20,
                fontFamily: 'Yekan Bakh',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: db.favorite.length,
              itemBuilder: (context, index) {
                List<String> item = db.favorite[index];
                return ListTile(
                  title: TextButton(
                      onPressed: () {
                        print(item[index][0]);
                      },
                      child: Text('print')),
                  trailing:
                      Text(item[2]), // Accessing the first element of each list
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
