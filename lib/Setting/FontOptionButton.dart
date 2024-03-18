// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';

class FontOptionButton extends StatefulWidget {
  String fontName;
  int fontBorder;
  final VoidCallback onTap;

  FontOptionButton({
    required this.fontName,
    required this.onTap,
    required this.fontBorder,
  });

  @override
  State<FontOptionButton> createState() => _FontOptionButtonState();
}

class _FontOptionButtonState extends State<FontOptionButton> {
  final _meBox2 = Hive.box('mybox2');

  @override
  void initState() {
    super.initState();
    if (_meBox2.get('borderFont') == null) {
      fontBorder.createInitialData();
    } else {
      fontBorder.loadData();
    }
  }

  final CAD = Get.put(ColorsClass());

  final int widh = 40;

  get colorPrimary => Color(0xFF009688);

  var fontClSize = fontsize();

  var fontsCl = fontsClass();
  ToDoDataBaseFont fontBorder = ToDoDataBaseFont();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: (widget.fontName == 'ایران سنس ایکس') ? 100 : 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: fontBorder.borderFont == widget.fontBorder
              ? Border.all(color: Color.fromRGBO(0, 150, 136, 1))
              : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Container(
            child: Text(
              widget.fontName,
              style: TextStyle(
                color:
                    fontBorder.borderFont == widget.fontBorder ? CAD.colorPrimary.value : CAD.colorWords,
                fontFamily: 'YekanBakh',
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
