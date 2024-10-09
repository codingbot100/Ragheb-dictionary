// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/ThemeData.dart';

class Mylist extends StatefulWidget {
  final String listName;
  final VoidCallback OntapLis;
  Mylist({required this.listName, required this.OntapLis});

  @override
  State<Mylist> createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  ThemeManager themeManager = Get.find();
  ThemeDatabase themeDatabase = ThemeDatabase();
  final thememanger = Get.put(ThemeManager());

  final _meBox2 = Hive.box('mybox2');
  ToDoDataBaseFont db = new ToDoDataBaseFont();

  @override
  void initState() {
    setState(() {
      themeDatabase.loadData();
      if (_meBox2.get("FontFamily") == null) {
        db.createInitialData();
      } else {
        db.loadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    bool isTable = screenWidth > 600;
    return GestureDetector(
      onTap: widget.OntapLis,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: !themeManager.themebo.value
                  ? Color.fromRGBO(255, 255, 255, 0.5)
                  : Color.fromRGBO(28, 28, 28, 1),
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 1),
              borderRadius: BorderRadius.circular(12.0),
              // color: Theme.of(context).colorScheme.surface, // boxShadow: [
              boxShadow: thememanger.themebo.value != true
                  ? [
                      BoxShadow(
                        spreadRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.07),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      )
                    ]
                  : []),
          alignment: Alignment.center,
          height: isTable ? 70 : 53,
          child: Center(
            child: ListTile(
              shape: RoundedRectangleBorder(side: BorderSide.none),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context)
                    .iconTheme
                    .color, // Use color from iconTheme
                size: isTable ? 23 : 17,
              ),
              leading: Text(
                widget.listName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: db.FontFamily,
                  fontSize: isTable ? 20 : 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
