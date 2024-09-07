import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';

class about_ragheb_dictionary extends StatefulWidget {
  const about_ragheb_dictionary({super.key});

  @override
  State<about_ragheb_dictionary> createState() =>
      _about_ragheb_dictionaryState();
}

class _about_ragheb_dictionaryState extends State<about_ragheb_dictionary> {
  var fontFamile2 = 'YekanBakh';
  double fontSizeSubTitle = 10.0;
  final colorPrimary = Color(0xFF009688);
  final colorBackground = Color.fromRGBO(245, 245, 220, 1);
  final colorPrimary2 = Color(0xFFB0BEC5);
  final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
  var TitleColor = Color.fromRGBO(0, 150, 136, 1);
  ThemeManager themeManager = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: themeManager.themebo.value?Color.fromRGBO(243, 243, 243, 1):Color.fromRGBO(0, 150, 136, 1),
                    ),
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                  Text(
                    'درباره فرهنگ لغت راغب',
                    style: TextStyle(
                      fontFamily: fontFamile2,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: TitleColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl, // Set the text direction here
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text(
                      'ترجمه لغات و اصطلاحات راغب',
                      style: TextStyle(
                        fontFamily: fontFamile2,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: themeManager.themebo.value
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(82, 82, 82, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              "اپلیکیشن موبایل فرهنگ لغت راغب با هدف ارائه یک ابزار"
                              " جامع و کار آمد برای ترجمه مفردات الفاظ قرآنکریم با تفسیر "
                              "لغوی و ادبی قرآنکریم در حدود 1500 لغت طراحی شده است. "
                              "این اپلیکیشن با بهره‌گیری از تکنولوژی‌ های بروز امکان"
                              " ترجمه‌ی سریع و دقیق واژگان را فراهم می‌آورد. دیکشنری"
                              " راغب شامل یک دیتابس اطلاعاتی گسترده از واژگان و"
                              "اصطلاحات است که کاربران می‌توانند به سادگی به آنها"
                              " دسترسی پیدا کنند و جهت فهم عمیق تر آیات قرآنی"
                              " . ",
                          style: TextStyle(
                            fontFamily: fontFamile2,
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            color: !themeManager.themebo.value
                                ? Color.fromRGBO(82, 82, 82, 1)
                                : Color.fromRGBO(204, 204, 204, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      child: RichText(
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              "تیم توسعه‌ دهنده HadidTech همواره در تلاش است تا با به‌روزرسانی‌های منظم و افزودن ویژگی‌های جدید، تجربه‌ی کاربری بهتری را برای کاربران فراهم آورد.",
                          style: TextStyle(
                            fontFamily: fontFamile2,
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            color: !themeManager.themebo.value
                                ? Color.fromRGBO(82, 82, 82, 1)
                                : Color.fromRGBO(204, 204, 204, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
