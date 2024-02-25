// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/HomePage/theme.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';

class Mylist extends StatelessWidget {
  final thme = MyTheme();
  final String listName;
  final VoidCallback OntapLis;
  Mylist({required this.listName, required this.OntapLis});
  var fontCl = fontsClass();
  var ColorCl = ColorsClass();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OntapLis,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: thme.colorBackground,
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 2), color: Color.fromRGBO(0, 0, 0, 0.08))
              ]),
          height: 42,
          child: ListTile(
            trailing: Icon(
              Icons.arrow_back_ios_new,
              size: 17,
            ),
            leading: Text(
              listName,
              style: TextStyle(
                fontFamily: fontCl.fonts[2],
                fontWeight: FontWeight.w700,
                color: ColorCl.colorPrimary.value,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
