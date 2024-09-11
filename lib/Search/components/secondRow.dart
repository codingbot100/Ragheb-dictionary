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
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600;
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
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  Color.fromRGBO(0, 150, 136, 1),
                ),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  TextStyle(
                    fontFamily: 'YekanBakh',
                    fontSize: isTablet ? 20 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
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
              child: Text("پاک کردن همه"),
            ),
          ),
          // SizedBox(width: 10),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromRGBO(0, 150, 136, 1),
            ),
          ),
          SizedBox(width: 12),
          Text("جستجو های اخیر",
              style: TextStyle(
                fontFamily: 'YekanBakh',
                fontSize: isTablet ? 20 : 12,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(0, 150, 136, 1),
              ))
        ],
      ),
    );
  }
}
