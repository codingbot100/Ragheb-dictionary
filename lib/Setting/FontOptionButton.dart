// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/fonts.dart';

class FontOptionButton extends StatefulWidget {
  String fontName;
  final bool isSelected;
  final VoidCallback onTap;

  FontOptionButton({
    required this.fontName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<FontOptionButton> createState() => _FontOptionButtonState();
}

class _FontOptionButtonState extends State<FontOptionButton> {
  late ToDoDataBaseFont dbFont;

  @override
  void initState() {
    super.initState();
    // Initialize the ToDoDataBaseFont instance
    dbFont = ToDoDataBaseFont();
  }

  final CAD = Get.put(ColorsClass());

  final int widh = 40;

  get colorPrimary => Color(0xFF009688);

  var fontClSize = fontsize();

  var fontsCl = fontsClass();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: (widget.fontName == 'ایران سنس ایکس') ? 100 : 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: widget.isSelected
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
                    widget.isSelected ? CAD.colorPrimary.value : CAD.colorWords,
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
