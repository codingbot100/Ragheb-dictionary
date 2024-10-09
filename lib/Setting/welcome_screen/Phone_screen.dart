import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Widgets/Navigator.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(PhoneWelcomeScreen());
}

class PhoneWelcomeScreen extends StatefulWidget {
  const PhoneWelcomeScreen({Key? key});

  @override
  _PhoneWelcomeScreenState createState() => _PhoneWelcomeScreenState();
}

List<String> titles = [
  "به اپلیکشن  فرهنگ لغت راغب خوش آمدید ",
  "امکانات و ویژگی‌ها",
  "شروع استفاده"
];
List<String> descriptions = [
  "ما با خوشحالی شما را در اپلیکیشن فرهنگ لغت راغب خوش‌آمد می‌گوییم. این اپلیکیشن جامع، ابزاری قدرتمند برای ترجمه و تفسیر واژگان قرآن کریم با بیش از 1500 لغت است. آماده‌اید تا سفر خود را برای فهم عمیق‌تر آیات قرآنی آغاز کنید؟",
  "اپلیکیشن فرهنگ لغت راغب با بهره‌گیری از تکنولوژی‌های بروز، امکان ترجمه‌ی سریع و دقیق واژگان را فراهم می‌آورد. با دسترسی به دیتابیس گسترده از واژگان و اصطلاحات، می‌ توانید به سادگی مفاهیم عمیق‌ تر آیات قرآنی را درک کنید.",
  "حال، آماده‌اید تا از تمامی امکانات این اپلیکیشن بهره ببرید؟ با استفاده از فرهنگ لغت راغب، تفسیر لغوی و ادبی قرآن کریم را به سادگی و سرعت تجربه کنید. سفر معنوی خود را همین حالا آغاز کنید!"
];
List<String> images = [
  'Welcome picture1.svg',
  "Welcom picture 2.svg",
  "Welcom picture 3.svg"
];
int myCurrentIndex = 0;

class _PhoneWelcomeScreenState extends State<PhoneWelcomeScreen> {
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(
                    'svg_images/Main Logo.svg',
                  ),
                ),
                Text(
                  'فرهنگ لغت راغب ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "YekanBakh",
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: SizedBox(
                height: height * 0.48,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                            // width: 300,
                            // height: 400,
                            margin: EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height *
                              -0.01, // Adjust position based on screen height

                          child: IntrinsicWidth(
                            stepHeight: height *
                                0.01, // Adjust the height based on screen height
                            child: Container(
                              width: width *
                                  0.7, // Adjust the width based on screen width

                              child: SvgPicture.asset(
                                "svg_images/${images[index]}",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height *
                                0.2, // Adjust padding based on screen height
                            left: MediaQuery.of(context).size.width *
                                0.07, // Adjust padding based on screen width
                            right: MediaQuery.of(context).size.width * 0.07,
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          titles[index],
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.030, // Adjust font size based on screen width
                                            fontFamily: "YekanBakh",
                                            fontWeight: FontWeight.w900,
                                            color:
                                                Color.fromRGBO(0, 150, 136, 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: RichText(
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            text: descriptions[index],
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.040, // Adjusts font size based on screen width
                                              fontFamily: "YekanBakh",
                                              fontWeight: FontWeight.w500,
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
                            ],
                          ),
                        ),
                        if (index == images.length - 1)
                          IconButton(
                              onPressed: () {
                                Get.to(() => MyAppNavigator(),
                                    transition: Transition.fadeIn,
                                    duration: Duration(milliseconds: 500));
                                splash.checkPage.value = true;
                                // splash.savePage;
                                splash.update;
                                // splash.updateDataBase();
                                print(splash.checkPage.value);
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Color.fromRGBO(0, 150, 136, 1)),
                                width: 170,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "شروع استفاده",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "YekanBakh",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  ],
                                ),
                              )),
                      ],
                    );
                  },
                ),
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
                    activeDotColor: Color.fromRGBO(0, 150, 136, 1),
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
    );
  }
}
