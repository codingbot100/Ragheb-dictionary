// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Search/DataBase/recent_Search.dart';
import 'package:ragheb_dictionary/Search/DataBase/Favorite_database.dart';
import 'package:ragheb_dictionary/Search/FavoritePages/FavoritePage%20.dart';
import 'package:ragheb_dictionary/WebLog/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/HomePage.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Search/search_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppNavigator extends StatefulWidget {
  @override
  State<MyAppNavigator> createState() => _MyAppNavigatorState();
}

class _MyAppNavigatorState extends State<MyAppNavigator>
    with WidgetsBindingObserver {
  late int _currentIndex;
  late List<Widget> buildScreens;
  late bool isShow;
  bool _isKeyboardVisible = false;
  int perviouseIndex = 0;
  final thememanger = Get.put(ThemeManager());
  ToDo_favorite toDo_favorite = ToDo_favorite();
  ToDoRecent toDo_recent = ToDoRecent();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    toDo_recent.loadData();
    toDo_favorite.loadData();
    isShow = false;

    _currentIndex = 0;
    buildScreens = [
      Home(
        SearchPage: (int currentPage) {
          setState(() {
            perviouseIndex = _currentIndex;

            _currentIndex = 2;
          });
        },
        onPageChange: (int currentPage) {
          setState(() {
            // perviouseIndex = _currentIndex;

            _currentIndex = currentPage;
            
          });
        },
      ),
      WebLog(
        onIndex: () {
          setState(() {
            perviouseIndex = _currentIndex;

            _currentIndex = 2;
          });
        },
      ),
      SearchPage(
        isShow: isShow,
      ),
      FavoritPage_Me(
        onchange: () {
          setState(() {
            perviouseIndex = _currentIndex;

            _currentIndex = 2;

          });
        },
      ),
   
      MySettingsPage(
        onChange: () {
          setState(() {
            perviouseIndex = _currentIndex;

            _currentIndex = 2;
            print(_currentIndex);
          });
        },
      ),
    ];
  }

  @override
  void didChangeMetrics() {
    // Check if the keyboard is visible
    final isKeyboardVisible =
        WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
    if (isKeyboardVisible != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = isKeyboardVisible;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool ShowFab = MediaQuery.of(context).viewInsets.bottom != 0;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents resizing when the keyboard is open

      body: AnimatedSwitcher(
        // switchInCurve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 350),
        child: buildScreens[_currentIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: _isKeyboardVisible
          ? SizedBox.shrink()
          : AnimatedContainer(
              duration: Duration(milliseconds: 350),
              height: ShowFab
                  ? isTablet
                      ? 110
                      : 87
                  : isTablet
                      ? 110
                      : 87,
              curve: Curves.fastEaseInToSlowEaseOut,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: Curves.fastEaseInToSlowEaseOut,
                decoration: BoxDecoration(
                    // boxShadow: thememanger.themebo.value
                    //     ? []
                    //     : [
                    //         BoxShadow(
                    //           color: Color.fromRGBO(245, 245, 220, 1),
                    //           blurRadius: 20.0,
                    //           offset: Offset(0, -20),
                    //         )
                    //       ],
                    ),
                child: BottomAppBar(
                  // colo:Color.fromRGBO(224, 224, 224, 0.678),
                  notchMargin: 7,
                  height: 65,
                  shape: toDo_favorite.favorite.isEmpty &&
                          toDo_recent.RecentSearch.isEmpty
                      ? CircularNotchedRectangle()
                      : null,
                  color: Theme.of(context).bottomAppBarTheme.color,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                _currentIndex == 0
                                    ? 'svg_images/clicked_home.svg'
                                    : 'svg_images/click_home.svg',
                                width: isTablet ? 30 : 25,
                                height: isTablet ? 30 : 25,
                              ),
                              onPressed: () => setState(() {
                                perviouseIndex = 0;

                                _currentIndex = 0;
                              }),
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              _currentIndex == 1
                                  ? 'svg_images/Clicked_weblog.svg'
                                  : 'svg_images/Click_welog.svg',
                              width: isTablet ? 30 : 25,
                              height: isTablet ? 30 : 25,
                            ),
                            onPressed: () => setState(() {
                              perviouseIndex = 1;
                              _currentIndex = 1;
                              print(_currentIndex);
                            }),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              _currentIndex == 3
                                  ? 'svg_images/State=Enable.svg'
                                  : 'svg_images/State=Disable.svg',
                              color: _currentIndex == 3
                                  ? Color.fromRGBO(0, 150, 136, 1)
                                  : Color.fromRGBO(111, 111, 111, 1),
                              width: isTablet ? 33 : 27,
                              height: isTablet ? 33 : 27,
                            ),
                            onPressed: () => setState(() {
                              perviouseIndex = 3;
                              _currentIndex = 3;
                            }),
                          ),
                          // _currentIndex == 2
                          //     ? IconButton(
                          //         onPressed: () {
                          //           Get.back();
                          //         },
                          //         icon: Icon(Icons.arrow_forward))
                          //     :
                          _currentIndex == 2
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _currentIndex = perviouseIndex;
                                    });
                                  },
                                  icon: Image.asset(
                                    'icons/back.png',
                                    scale: 3.5,
                                  ),
                                )
                              : IconButton(
                                  icon: SvgPicture.asset(
                                    _currentIndex == 4
                                        ? 'svg_images/clicked_setting.svg'
                                        : 'svg_images/setting2.svg',
                                    width: isTablet ? 35 : 25,
                                    height: isTablet ? 35 : 25,
                                  ),
                                  onPressed: () => setState(() {
                                    perviouseIndex = 4;
                                    _currentIndex = 4;
                                    
                                  }),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ),
              )),
      // floatingActionButton: Visibility(
      //   visible: !ShowFab &&
      //       toDo_favorite.favorite.isEmpty &&
      //       toDo_recent.RecentSearch.isEmpty,
      //   child: ClipOval(
      //     child: FloatingActionButton(
      //       foregroundColor: Colors.transparent,
      //       onPressed: () => setState(() => _currentIndex = 2),
      //       tooltip: 'Search',
      //       child: SvgPicture.asset(
      //         "svg_images/search_button.svg",
      //         height: 30,
      //         color: Colors.white,
      //       ),
      //       elevation: 2.0,
      //       backgroundColor: Color(0xFF009688),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
