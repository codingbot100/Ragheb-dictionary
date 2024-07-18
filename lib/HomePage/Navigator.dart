// ignore_for_file: deprecated_member_use

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
  int perviouseIndex = 0;
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
            print(_currentIndex);
          });
        },
      ),
      WebLog(
        onIndex: () {
          setState(() {
            perviouseIndex = _currentIndex;

            _currentIndex = 2;
            print(_currentIndex);
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

            print(_currentIndex);
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
  Widget build(BuildContext context) {
    bool ShowFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: AnimatedSwitcher(
        // switchInCurve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: buildScreens[_currentIndex] == 0 ? 0 : 350),
        child: buildScreens[_currentIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: !ShowFab ? 87 : 0,
          curve: Curves.fastEaseInToSlowEaseOut,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
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
              // coloColor.fromRGBO(224, 224, 224, 0.678)24),
              // notchMargin: 7,
              height: 65,
              // shape: CircularNotchedRectangle(),
              color: Theme.of(context).bottomAppBarTheme.color,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        curve: Curves.bounceInOut,
                        width: 40,
                        height: 40,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _currentIndex == 0
                                ? 'svg_images/clicked_home.svg'
                                : 'svg_images/click_home.svg',
                            width: 45,
                            height: 40,
                          ),
                          onPressed: () => setState(() {
                            perviouseIndex = 0;

                            _currentIndex = 0;
                            print(_currentIndex);
                          }),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      curve: Curves.bounceInOut,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          _currentIndex == 1
                              ? 'svg_images/Clicked_weblog.svg'
                              : 'svg_images/Click_welog.svg',
                          width: 25,
                          height: 25,
                        ),
                        onPressed: () => setState(() {
                          perviouseIndex = 1;
                          _currentIndex = 1;
                          print(_currentIndex);
                        }),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      curve: Curves.bounceInOut,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          _currentIndex == 3
                              ? 'svg_images/State=Enable.svg'
                              : 'svg_images/State=Disable.svg',
                          color: _currentIndex == 3
                              ? Color.fromRGBO(0, 150, 136, 1)
                              : Color.fromRGBO(111, 111, 111, 1),
                          width: 27,
                          height: 27,
                        ),
                        onPressed: () => setState(() {
                          perviouseIndex = 3;
                          _currentIndex = 3;
                          print(_currentIndex);
                        }),
                      ),
                    ),
                    // _currentIndex == 2
                    //     ? IconButton(
                    //         onPressed: () {
                    //           Get.back();
                    //         },
                    //         icon: Icon(Icons.arrow_forward))
                    //     :
                    _currentIndex == 2
                        ? Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentIndex = perviouseIndex;
                                  print(_currentIndex);
                                });
                              },
                              icon: Image.asset(
                                'icons/back.png',
                                scale: 4.5,
                              ),
                            ),
                          )
                        : AnimatedContainer(
                            duration: Duration(milliseconds: 0),
                            curve: Curves.bounceInOut,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                _currentIndex == 4
                                    ? 'svg_images/clicked_setting.svg'
                                    : 'svg_images/setting2.svg',
                                width: 25,
                                height: 25,
                              ),
                              onPressed: () => setState(() {
                                perviouseIndex = 4;
                                _currentIndex = 4;
                                print(_currentIndex);
                              }),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // ),
          )),
      // floatingActionButton: Visibility(
      //   visible: !ShowFab,
      //   child: ClipOval(
      //     child: FloatingActionButton(
      //       foregroundColor: Colors.transparent,
      //       onPressed: () => setState(() => _currentIndex = 2),
      //       tooltip: 'Search',
      //       child: Icon(
      //         Icons.search,
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
