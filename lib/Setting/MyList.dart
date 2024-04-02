// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/theme.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/themeData.dart';

class Mylist extends StatefulWidget {
  final String listName;
  final VoidCallback OntapLis;
  Mylist({required this.listName, required this.OntapLis});

  @override
  State<Mylist> createState() => _MylistState();
}

class _MylistState extends State<Mylist> {
  ThemeDatabase themeDatabase = ThemeDatabase();
  final thememanger = Get.put(ThemeManager());

  final _meBox2 = Hive.box('mybox2');
  final thme = MyTheme();
  ToDoDataBaseFont db = new ToDoDataBaseFont();
  var fontCl = fontsClass();

  var ColorCl = ColorsClass();
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
    return GestureDetector(
      onTap: widget.OntapLis,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 1),
              borderRadius: BorderRadius.circular(12.0),
              color: Theme.of(context).colorScheme.background, // boxShadow: [
              boxShadow: thememanger.themebo.value != true
                  ? [
                      BoxShadow(
                          offset: Offset(2, 2),
                          color: Theme.of(context).shadowColor)
                    ]
                  : []),
          alignment: Alignment.center,
          height: 53,
          child: Center(
            child: ListTile(
              shape: RoundedRectangleBorder(side: BorderSide.none),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context)
                    .iconTheme
                    .color, // Use color from iconTheme
                size: 17,
              ),
              leading: Text(
                widget.listName,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: db.FontFamily,
                  // color: ColorCl.colorPrimary.value,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
