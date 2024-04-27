import "package:flutter/material.dart";
import "package:ragheb_dictionary/Search/components/dialog_box.dart";

class secondRow extends StatefulWidget {
  const secondRow({super.key});

  @override
  State<secondRow> createState() => _secondRowState();
}

class _secondRowState extends State<secondRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 28,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogeBox();
                  },
                );
              });
            },
            child: Text("پاک کردن",
                style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 12,
                  // color: Color.fromRGBO(0, 0, 0, 0.7)
                )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(width: 10),
          Text("جستجو های اخیر",
              style: TextStyle(
                fontFamily: 'YekanBakh',
                fontSize: 12,
                // color: Color.fromRGBO(0, 0, 0, 0.7)
              ))
        ],
      ),
    );
  }
}
