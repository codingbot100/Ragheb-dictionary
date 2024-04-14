import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/HomePage/WebLog/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last%20.dart';
import 'package:ragheb_dictionary/search_Page/RecentPageSecond.dart';
import 'package:ragheb_dictionary/search_Page/data/isShow.dart';
import 'package:ragheb_dictionary/search_Page/util/search_pageMe.dart';
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
      RecentpageSecond()
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
      bottomNavigationBar: Obx(() => Visibility(
            visible: ShowClass.isShow.value,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: ShowClass.isShow.value ? 65 : 0,
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
                      Container(
                        width: 55,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 0
                                ? 'Image_WelcomPage/clicked_home.svg'
                                : 'Image_WelcomPage/click_home.svg',
                          ),
                          onPressed: () => setState(() => _currentIndex = 0),
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          _currentIndex == 1
                              ? 'Image_WelcomPage/Clicked_weblog.svg'
                              : 'Image_WelcomPage/Click_welog.svg',
                        ),
                        onPressed: () => setState(() => _currentIndex = 1),
                      ),
                      SizedBox(), // Spacer for the center space
                      IconButton(
                        icon: SvgPicture.asset(
                          _currentIndex == 3
                              ? 'Image_WelcomPage/State=Enable.svg'
                              : 'Image_WelcomPage/State=Disable.svg',
                        ),
                        onPressed: () => setState(() => _currentIndex = 3),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          _currentIndex == 4
                              ? 'Image_WelcomPage/clicked_setting.svg'
                              : 'Image_WelcomPage/setting2.svg',
                        ),
                        onPressed: () => setState(() => _currentIndex = 4),
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
