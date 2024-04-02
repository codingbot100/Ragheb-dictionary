import 'package:flutter/material.dart';
import 'package:get/get.dart';

class about_Us extends StatefulWidget {
  const about_Us({super.key});

  @override
  State<about_Us> createState() => _about_UsState();
}

class _about_UsState extends State<about_Us> {
  var fontFamile2 = 'YekanBakh';
  double fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color.fromRGBO(245, 245, 220, 1);
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var TitleColor = Color.fromRGBO(0, 150, 136, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30, top: 10),
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl, // Set the text direction here
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(side: BorderSide.none),
                  tileColor: Colors.transparent,
                  trailing: Text(
                    'درباره ما ',
                    style: TextStyle(
                      fontFamily: fontFamile2,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      // color: TitleColor,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "گروه برنامه نویسان حدید",
                    style: TextStyle(
                      fontFamily: fontFamile2,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      // color: Color.fromRGBO(82, 82, 82, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    width: 300,
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
                            'کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد.',
                        style: TextStyle(
                          fontFamily: fontFamile2,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          // color: Color.fromRGBO(82, 82, 82, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
