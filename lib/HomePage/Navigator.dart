import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/HomePage/WebLog/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last%20.dart';
import 'package:ragheb_dictionary/search_Page/RecentPageSecond.dart';
import 'package:ragheb_dictionary/search_Page/util/search_pageMe.dart';

class MyAppNavigator extends StatefulWidget {
  @override
  State<MyAppNavigator> createState() => _MyAppNavigatorState();
}

class _MyAppNavigatorState extends State<MyAppNavigator> {
  late int _currentIndex;
  late List<Widget> buildScreens;
  late bool isShow;
  final thememanger = Get.put(ThemeManager());
  @override
  void initState() {
    super.initState();
    isShow = false;
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
      body: buildScreens[_currentIndex],
      bottomNavigationBar: Visibility(
        visible: !ShowFab,
        child: Container(
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
                      icon: Image.asset(
                        _currentIndex == 0
                            ? 'icons/CloseHome.png'
                            : 'icons/OpenHome.png',
                        scale: _currentIndex == 0 ? 3 : 5,
                      ),
                      onPressed: () => setState(() => _currentIndex = 0),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      _currentIndex == 1
                          ? 'icons/OpenWeblog.png'
                          : 'icons/weblog.png',
                      scale: _currentIndex == 1 ? 3 : 4.5,
                    ),
                    onPressed: () => setState(() => _currentIndex = 1),
                  ),
                  SizedBox(), // Spacer for the center space
                  IconButton(
                    icon: Image.asset(
                      _currentIndex == 3
                          ? 'icons/State=Enable.png'
                          : 'icons/State=Disable.png',
                      scale: 1.5,
                      cacheWidth: 150,
                      color: Color.fromRGBO(0, 150, 136, 1),
                    ),
                    onPressed: () => setState(() => _currentIndex = 3),
                  ),
                  IconButton(
                    icon: Image.asset(
                      _currentIndex == 4
                          ? 'icons/OpenSetting.png'
                          : 'icons/newSetting.png',
                      scale: _currentIndex == 4 ? 3 : 4.5,
                    ),
                    onPressed: () => setState(() => _currentIndex = 4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
