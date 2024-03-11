import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ragheb_dictionary/HomePage/WebLog.dart';
import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last%20.dart';
import 'package:ragheb_dictionary/search_Page/util/search_pageMe.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('mybox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CAD = Get.put(ColorsClass());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xFFF5F5DC),
        appBarTheme: AppBarTheme(
          color: Color(0xFFF5F5DC),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyAppNavigator(),
    );
  }
}

class MyAppNavigator extends StatefulWidget {
  @override
  State<MyAppNavigator> createState() => _MyAppNavigatorState();
}

class _MyAppNavigatorState extends State<MyAppNavigator> {
  PersistentTabController? _controller;

  List<Widget> buildScreen = [
    Home(),
    message(),
    SearchPageMe(),
    FavoritPage_Me(),
    MySettingsPage(),
  ];

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'icons/CloseHome.png',
          scale: 3,
        ),
        inactiveIcon: Image.asset(
          'icons/OpenHome.png',
          scale: 4.5,
        ),
      ),
      PersistentBottomNavBarItem(
          icon: Image.asset(
            'icons/OpenWeblog.png',
            scale: 3,
          ),
          inactiveIcon: Image.asset(
            "icons/weblog.png",
            scale: 4.5,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF009688),
          icon: Image.asset('images/magnifier.png',
              cacheWidth: 150, scale: 6, color: Colors.lightGreen),
          inactiveIcon: Image.asset('images/magnifier.png',
              cacheWidth: 150, scale: 6, color: Colors.white)),
      PersistentBottomNavBarItem(
          icon: Image.asset('images/bookmark (1).png',
              cacheWidth: 150, scale: 5, color: Color(0xFF009688)),
          inactiveIcon: Image.asset("images/bookmark (2).png",
              cacheWidth: 150, scale: 5, color: Color(0xFF009688))),
      PersistentBottomNavBarItem(
          icon: Image.asset(
            'icons/OpenSetting.png',
            scale: 3,
          ),
          inactiveIcon: Image.asset(
            "icons/newSetting.png",
            scale: 4.5,
          )),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: 70,
      context,
      controller: _controller,
      screens: buildScreen,
      items: _navBarItem(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFFE0E0BF),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      itemAnimationProperties: ItemAnimationProperties(
        // Set your desired color for the active tab indicator

        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
