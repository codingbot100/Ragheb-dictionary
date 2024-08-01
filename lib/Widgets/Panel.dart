import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';

// ignore: must_be_immutable
class Panel extends StatefulWidget {
  String Title;
  void Function() onChange;
  Panel({super.key, required this.onChange, required this.Title});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  ToDoDataBaseFont Db_Font = ToDoDataBaseFont();
  @override
  void initState() {
    super.initState();
    Db_Font.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.Title,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontFamily: Db_Font.FontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(0, 153, 136, 1)),
          ),
          IconButton(
            onPressed: () {
              widget.onChange(); // Use onChange directly
              print("change");
            },
            icon: SvgPicture.asset(
              "svg_images/search_new.svg",
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(0, 150, 136, 1),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
