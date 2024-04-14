import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/search_Page/data/database.dart';
import 'package:ragheb_dictionary/search_Page/util/detailFavoritePage.dart';

class FavoritPage_second extends StatefulWidget {
  @override
  _FavoritPage_secondState createState() => _FavoritPage_secondState();
}

class _FavoritPage_secondState extends State<FavoritPage_second> {
  ToDodatabase3 _todoDatabase = ToDodatabase3();
  ToDodatabase6 db6 = ToDodatabase6();
  final _meBox = Hive.box('mybox');

  @override
  void initState() {
    if (_meBox.get('TODOSlid') == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
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
        // backgroundColor: Color(0xFFF5F5DC),
        body: Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: _todoDatabase.favorite.length,
            itemBuilder: (context, index) {
              return Container(
                height: 37,
                child: ListTile(
                  shape: RoundedRectangleBorder(side: BorderSide.none),
                  tileColor: Colors.transparent,
                  trailing: Text(
                    "${_todoDatabase.favorite[index]['name']}",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Get.to(
                        () => DetailFavoirtPage(
                            name: "${_todoDatabase.favorite[index]['name']}",
                            description:
                                "${_todoDatabase.favorite[index]['description']}",
                            footnote:
                                "${_todoDatabase.favorite[index]['footnote']}",
                            initialPageIndex: index),
                        transition: Transition.fadeIn,
                        duration: Duration(milliseconds: 200));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  thickness: 0.5,
                  // color: Color.fromRGBO(0, 150, 136, 0.5),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
