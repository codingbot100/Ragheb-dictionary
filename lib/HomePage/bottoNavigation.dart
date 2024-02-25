import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ragheb_dictionary/HomePage/WebLog.dart';
import 'package:ragheb_dictionary/Setting/SettingPage.dart';
import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/search_Page/FavoritePage_last.dart';
import 'package:ragheb_dictionary/search_Page/search_Page.dart';

class moon extends StatelessWidget {
  const moon({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: bottm(),
    );
  }
}

class bottm extends StatefulWidget {
  @override
  State<bottm> createState() => _bottmState();
}

class _bottmState extends State<bottm> {
  int _selectedPageIndex = 0;
  late List<Map<String, Widget>> _pages;

  @override
  void initState() {
    _pages = [
      {'Page': Home()},
      {'Page': message()},
      {'Page': message()},
      {'Page': MySettingsPage()},
      {}
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['Page'],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => search_page(),
            curve: Curves.fastEaseInToSlowEaseOut,
            transition: Transition.downToUp,
          );
        },
        child: Icon(
          Icons.search,
          color: Colors.white,
          size: 27,
        ),
        shape: CircleBorder(),
        backgroundColor: Color.fromRGBO(0, 150, 136, 1),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          notchMargin: 8.0,
          height: 80,
          shape: CircularNotchedRectangle(),
          color: Color.fromRGBO(224, 224, 191, 1),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                0,
                Iconsax.home,
              ),
              buildNavItem(1, Iconsax.message4),
              buildNavItem(2, Iconsax.search_favorite_1),
              buildNavItem(3, Iconsax.setting_24),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, IconData icon) {
    return GestureDetector(
      onTap: () => _selectPage(index), // Corrected to call _selectPage
      child: Icon(
        icon,
        color: _selectedPageIndex == index
            ? Color.fromARGB(234, 44, 140, 47)
            : Colors.purple,
      ),
    );
  }
}
