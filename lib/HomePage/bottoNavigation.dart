import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ragheb_dictionary/HomePage/MessagePage.dart';

import 'package:ragheb_dictionary/HomePage/SettingPage.dart';

import 'package:ragheb_dictionary/HomePage/menu.dart';
import 'package:ragheb_dictionary/HomePage/searchPage/searchPage.dart';
import 'package:ragheb_dictionary/searchDB.dart/favoitPage3.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: bottm()));
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
      {'Page': FavoritePage32()},
      {'Page': MySettingsPage()},
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
            () => Listbar(),
            curve: Curves.fastEaseInToSlowEaseOut,
            transition: Transition.downToUp,
            // duration: Duration(milliseconds: 900)
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