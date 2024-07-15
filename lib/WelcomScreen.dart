import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(WelcomScreen());
}

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({Key? key});

  @override
  _WelcomScreenState createState() => _WelcomScreenState();
}

List<String> titles = ["این چیه؟", "چی داره؟", "دیگه چی داره؟"];
List<String> descriptions = [
  "مجموعه ترجمه لغات و اصطلاحات قرآنی به زبان شیوای فارسی برای مشتاقان معانی قرآنکریم و محققان زبان عربی",
  "قابلیت‌های جستجوی لغات، افزودن لغات به لیست علاقه‌مندی ها و مجموعه مقالات با محتوای ناب مفاهیم اسلامی",
  "قابلیت شخصی سازی فونت، رنگ و اندازه قلم، تیم پشتیبانی سریع در صورت بروز مشکل و ارائه بازخورد"
];
List<String> images = [
  'Welcome picture1.svg',
  "Welcom picture 2.svg",
  "Welcom picture 3.svg"
];
int myCurrentIndex = 0;

class _WelcomScreenState extends State<WelcomScreen> {
  PageController _controller = PageController();
  final splash = Get.put(splashclass());
  splashclass splashData = splashclass();
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        myCurrentIndex = _controller.page!
            .round(); // Update myCurrentIndex based on PageView index
      });
    });
    super.initState();
  }

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
                child: SvgPicture.asset(
                  'svg_images/Main Logo.svg',
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
                            child: SvgPicture.asset(
                              "svg_images/${images[index]}",
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              width: 218,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        titles[index],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "YekanBakh",
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(0, 150, 136, 1),
                                        ),
                                      ),
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
                                splash.checkPage.value = true;
                                splash.savePage;
                                splash.update;
                                splash.updateDataBase();
                                print(splash.checkPage.value);
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
                              )),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Container(
                  height: 9,
                  child: AnimatedSmoothIndicator(
                    activeIndex: myCurrentIndex,
                    count: images.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 5,
                      dotWidth: 5,
                    ),
                    curve: Curves.easeInBack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
