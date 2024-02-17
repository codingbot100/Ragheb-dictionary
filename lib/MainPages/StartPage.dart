import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/MainPages/EnterAnimation.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  runApp(start());
}

class start extends StatelessWidget {
  final CAD = Get.put(ColorsClass());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: enteringPage(),
    );
  }
}
