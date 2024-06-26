import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Search/FavoritePage%20.dart';
import 'package:ragheb_dictionary/WebLog/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/HomePage.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Search/DataBase/isShow.dart';
import 'package:ragheb_dictionary/Search/search_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppNavigator extends StatefulWidget {
  @override
  State<MyAppNavigator> createState() => _MyAppNavigatorState();
}

class _MyAppNavigatorState extends State<MyAppNavigator> {
  late int _currentIndex;
  late List<Widget> buildScreens;
  late bool isShow;
  final ShowClass = Get.put(show());

  final thememanger = Get.put(ThemeManager());
  @override
  void initState() {
    super.initState();
    isShow = false;
    setState(() {
      ShowClass.isShow.value;
    });
    _currentIndex = 0;
    buildScreens = [
      Home(
        onPageChange: (int currentPage) {
          setState(() {
            _currentIndex = currentPage;
          });
        },
      ),
      message(),
      SearchPageMe(
        isShow: isShow,
      ),
      FavoritPage_Me(),
      MySettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool ShowFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: AnimatedSwitcher(
        // switchInCurve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 350),
        child: buildScreens[_currentIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Obx(() => AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: !ShowFab ? 65 : 0,
            curve: Curves.fastEaseInToSlowEaseOut,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1),
              curve: Curves.fastEaseInToSlowEaseOut,
              decoration: BoxDecoration(
                boxShadow: thememanger.themebo.value
                    ? []
                    : [
                        BoxShadow(
                          color: Color.fromRGBO(245, 245, 220, 1),
                          blurRadius: 20.0,
                          offset: Offset(0, -20),
                        )
                      ],
              ),
              child: BottomAppBar(
                notchMargin: 7,
                height: 65,
                shape: CircularNotchedRectangle(),
                color: Theme.of(context).bottomAppBarColor,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        width: 55,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 0
                                ? 'svg_images/clicked_home.svg'
                                : 'svg_images/click_home.svg',
                          ),
                          onPressed: () => setState(() => _currentIndex = 0),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 1
                                ? 'svg_images/Clicked_weblog.svg'
                                : 'svg_images/Click_welog.svg',
                          ),
                          onPressed: () => setState(() => _currentIndex = 1),
                        ),
                      ),
                      SizedBox(), // Spacer for the center space
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 3
                                ? 'svg_images/State=Enable.svg'
                                : 'svg_images/State=Disable.svg',
                            color: Color.fromRGBO(111, 111, 111, 1),
                          ),
                          onPressed: () => setState(() => _currentIndex = 3),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 4
                                ? 'svg_images/clicked_setting.svg'
                                : 'svg_images/setting2.svg',
                          ),
                          onPressed: () => setState(() => _currentIndex = 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
      floatingActionButton: Visibility(
        visible: !ShowFab,
        child: ClipOval(
          child: FloatingActionButton(
            foregroundColor: Colors.transparent,
            onPressed: () => setState(() => _currentIndex = 2),
            tooltip: 'Search',
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            elevation: 2.0,
            backgroundColor: Color(0xFF009688),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
