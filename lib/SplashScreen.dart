import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/search_Page/data/splashData.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

List<String> titles = ["این چیه؟", "چی داره؟", "دیگه چی داره؟"];
List<String> descriptions = [
  "قابلیت‌های جستجوی لغات، افزودن لغات به لیست علاقه‌مندی ها و مجموعه مقالات با محتوای ناب مفاهیم اسلامی",
  "قابلیت شخصی سازی فونت، رنگ و اندازه قلم، تیم پشتیبانی سریع در صورت بروز مشکل و ارائه بازخورد",
  "قابلیت شخصی سازی فونت، رنگ و اندازه قلم، تیم پشتیبانی سریع در صورت بروز مشکل و ارائه بازخورد"
];
List<String> images = ['first p.png', "second p.png", "threed p.png"];

class _SplashScreenState extends State<SplashScreen> {
  PageController _controller = PageController();
  final splash = Get.put(splashclass());
  splashclass splashData = splashclass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'images/Main Logo.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'فرهنگ لغت راغب ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "YekanBakh",
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(250, 250, 238, 1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 20,
                                    offset: Offset(0, 0))
                              ]),
                          width: 266,
                          height: 366,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              'Responsive Container',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -25,
                          child: Container(
                            height: 196,
                            child: Image.asset(
                              "images/${images[index]}",
                              scale: 1,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25, top: 40),
                            child: Container(
                              width: 218,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "YekanBakh",
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(0, 150, 136, 1),
                                    ),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: RichText(
                                        textAlign: TextAlign.justify,
                                        text: TextSpan(
                                          text: descriptions[index],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "YekanBakh",
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                111, 111, 111, 1),
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
                        if (index == images.length - 1)
                          IconButton(
                            onPressed: () {
                              Get.to(() => MyAppNavigator(),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 500));
                              setState(() {
                                splash.loadData();
                                splash.checkPage.value = true;
                                splash.updateDataBase();
                              });
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color.fromRGBO(0, 150, 136, 1)),
                              width: 130,
                              height: 31,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "متوجه شدم ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: "YekanBakh",
                                    ),
                                  ),
                                  Icon(Iconsax.arrow_right_14,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
