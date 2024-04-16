import "package:flutter/material.dart";

class secondRow extends StatelessWidget {
  const secondRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        
        left: 20,
        right: 28,
      ),
      child: Row(
        children: [
          Text("پاک کردن",
              style: TextStyle(
                  fontFamily: 'YekanBakh',
                  fontSize: 12,
                  // color: Color.fromRGBO(0, 0, 0, 0.7)
                  )),
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
