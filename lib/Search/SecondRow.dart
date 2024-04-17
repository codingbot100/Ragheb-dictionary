import "package:flutter/material.dart";
import "package:ragheb_dictionary/Search/DataBase/recent_Search.dart";
import "package:ragheb_dictionary/Search/components/dialog_box.dart";

class secondRow extends StatefulWidget {
  const secondRow({super.key});

  @override
  State<secondRow> createState() => _secondRowState();
}

class _secondRowState extends State<secondRow> {
  ToDoRecent db = ToDoRecent();

  void removeAll() {
    setState(() {
      db.favorite.clear();
      db.updateDataBase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 9,
        right: 18,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() async {
                ShowDilog();
              });
            },
            child: Text("پاک کردن",
                style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 12,
                )),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              thickness: 0.1,
            ),
          ),
          SizedBox(width: 10),
          Visibility(
            visible: true,
            child: Text(" جستجو های اخیر",
                style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 12,
                  // color: Color.fromRGBO(0, 0, 0, 0.7)
                )),
          )
        ],
      ),
    );
  }

  void ShowDilog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogeBox();
      },
    );
  }
}
