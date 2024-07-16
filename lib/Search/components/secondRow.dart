import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:ragheb_dictionary/Search/components/dialog_box.dart";
import "package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart";

class secondRow extends StatefulWidget {
  final void Function() onClear;

  const secondRow({super.key, required this.onClear});

  @override
  State<secondRow> createState() => _secondRowState();
}

class _secondRowState extends State<secondRow> {
  ThemeManager themeManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 18,
      ),
      child: Row(
        children: [
          Container(
            // height: 36,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogeBox(
                        onClear: widget.onClear,
                      );
                    },
                  );
                });
              },
              child: Text("پاک کردن همه",
                  style: TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: !themeManager.themebo.value
                        ? Color.fromRGBO(0, 150, 136, 0.5)
                        : Color.fromRGBO(153, 150, 153, 1),
                  )),
            ),
          ),
          // SizedBox(width: 10),
          Expanded(
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(width: 12),
          Text("جستجو های اخیر",
              style: TextStyle(
                fontFamily: 'YekanBakh',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
    );
  }
}
