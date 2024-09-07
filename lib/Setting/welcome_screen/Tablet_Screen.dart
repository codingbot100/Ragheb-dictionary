import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';



class TabletWelcomScreen extends StatefulWidget {
  const TabletWelcomScreen({Key? key});

  @override
  _TabletWelcomScreenState createState() => _TabletWelcomScreenState();
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

class _TabletWelcomScreenState extends State<TabletWelcomScreen> {
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
        padding: EdgeInsets.only(top: height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(
                    height: height * 0.09,
                    'svg_images/Main Logo.svg',
                  ),
                ),
                Text(
                  'فرهنگ لغت راغب ',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontFamily: "YekanBakh",
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                height: height * 0.55,
                // width: width * 0.50,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: width * 0.65,
                          height: height * 0.45, // Keep the fixed height
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 238, 1),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                blurRadius: 20,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15,
                              left: MediaQuery.of(context).size.width * 0.07,
                              right: MediaQuery.of(context).size.width * 0.07,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize
                                  .max, // Keep max to not shrink height
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        titles[index],
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
                                          fontFamily: "YekanBakh",
                                          fontWeight: FontWeight.w900,
                                          color: Color.fromRGBO(0, 150, 136, 1),
                                        ),
                                        maxLines:
                                            2, // Limit the lines to avoid expanding the height
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  // Use Expanded to keep the text within the set height
                                  child: SingleChildScrollView(
                                    // Scroll if text is too long
                                    child: Container(
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
                                                  0.033,
                                              fontFamily: "YekanBakh",
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  111, 111, 111, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // SvgPicture remains at the top
                        Positioned(
                          top: MediaQuery.of(context).size.height * -0.01,
                          child: Container(
                            width: width * 0.7,
                            child: SvgPicture.asset(
                              height: height * 0.27,
                              "svg_images/${images[index]}",
                            ),
                          ),
                        ),

                        if (index == images.length - 1)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              onPressed: () {
                                Get.to(() => MyAppNavigator(),
                                    transition: Transition.fadeIn,
                                    duration: Duration(milliseconds: 500));
                                splash.checkPage.value = true;
                                splash.update;
                                print(splash.checkPage.value);
                              },
                              icon: LayoutBuilder(
                                builder: (context, constraints) {
                                  // Adjust the dimensions based on the screen width
                                  double screenWidth =
                                      MediaQuery.of(context).size.width;

                                  // Define breakpoints for different device types
                                  bool isTablet = screenWidth >
                                      600; // Example breakpoint for tablets

                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Color.fromRGBO(0, 150, 136, 1),
                                    ),
                                    width: isTablet
                                        ? 250
                                        : 170, // Adjust width for tablets
                                    height: isTablet
                                        ? 50
                                        : 35, // Adjust height for tablets
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "شروع استفاده",
                                          style: TextStyle(
                                            fontSize: isTablet
                                                ? 25
                                                : 16, // Adjust font size for tablets
                                            color: Colors.white,
                                            fontFamily: "YekanBakh",
                                          ),
                                        ),
                                        SizedBox(
                                            width: isTablet
                                                ? 6
                                                : 4), // Adjust spacing for tablets
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: isTablet
                                              ? 26
                                              : 16, // Adjust icon size for tablets
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.1, // Adjust top padding based on screen height
              ),
              child: Container(
                height: height * 0.012, // Adjust height based on screen height
                child: AnimatedSmoothIndicator(
                  activeIndex: myCurrentIndex,
                  count: images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color.fromRGBO(0, 150, 136, 1),
                    dotHeight:
                        width * 0.01, // Adjust dot height based on screen width
                    dotWidth:
                        width * 0.01, // Adjust dot width based on screen width
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
