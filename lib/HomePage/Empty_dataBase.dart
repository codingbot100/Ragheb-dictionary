import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

main() {
  runApp(No_Rep());
}

class No_Rep extends StatefulWidget {
  const No_Rep({Key? key}) : super(key: key);

  @override
  State<No_Rep> createState() => _No_RepState();
}

class _No_RepState extends State<No_Rep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: SvgPicture.asset("svg_images/first_time_use.svg")),
            Text(
              "!" + "هنوز هیچ سابقه ای ندارید",
              style: TextStyle(
                  fontFamily: "YekanBakh",
                  color: Color.fromRGBO(0, 150, 136, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              width: 254,
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        "برای نمایش بخش های جذاب اپلیکیشن، جستجو کنید و لیست علاقه‌مندی های خویش را بسازید",
                    style: TextStyle(
                        fontFamily: "Inter",
                        color: Color.fromRGBO(0, 150, 136, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
