import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Tools_Menu/ThemeDatabase.dart';

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
                    color: Color.fromRGBO(243, 243, 243, 1),
                  ),
                  Text(
                    "درباره ما",
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
                      "گروه برنامه نویسان حدید",
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
                              "شرکت Hadid Tech یک تیم توسعه‌دهنده متعهد و متخصص در حوزه فناوری اطلاعات و ارتباطات است. این تیم از ترکیبی از متخصصان با تجربه در زمینه‌های مختلف فناوری تشکیل شده است که با هم به ایجاد و توسعه نرم‌افزارها و راه‌حل‌های نوآورانه می‌پردازند.",
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
                              "تیم Hadid Tech با تمرکز بر کیفیت، دقت و نوآوری، توانسته است پروژه‌های متعددی را با موفقیت به انجام برساند. اعضای این تیم از دانش و مهارت‌های به‌روز برخوردار هستند و همواره در تلاشند تا با استفاده از تکنولوژی‌های پیشرفته و متدولوژی‌های مدرن، بهترین خدمات را به مشتریان خود ارائه دهند.",
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
                              "ماموریت Hadid Tech، فراهم کردن راه‌حل‌های فناوری اطلاعات است که به بهبود کارایی و بهره‌وری کسب‌وکارها کمک کند. این تیم با ارتباط موثر و همکاری نزدیک با مشتریان خود، نیازها و اهداف آنها را به خوبی درک کرده و راه‌حل‌های سفارشی و مناسب برای هر کسب‌وکار را ارائه می‌دهد.",
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
