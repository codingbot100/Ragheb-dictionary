import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';

class FavoritPage_menu extends StatefulWidget {
  @override
  _FavoritPage_menuState createState() => _FavoritPage_menuState();
}

class _FavoritPage_menuState extends State<FavoritPage_menu> {
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

  bool isFavorit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: _todoDatabase.favorite.length,
          itemBuilder: (context, index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5DC),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 228, 228, 134)
                              .withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: ListTile(
                    leading:GestureDetector(
                      onTap: (){
                        setState(() {
                          isFavorit =!isFavorit;
                        });
                      },
                      child: Image.asset(isFavorit ? 'icons/true f.png':'icons/favorite.png',
                        scale: 2,
                      ),
                    ),
                    title: Text(
                      _todoDatabase.favorite[index]['name'],
                      style: TextStyle(
                          fontFamily: 'Yekan Bakh',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  )),
            );

            // You can add more Text widgets for other properties if needed
          },
        ),
      ),
    );
  }
}
