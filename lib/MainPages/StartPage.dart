import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/MainPages/EnterAnimation.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';

main() {
  runApp(start());
}

class start extends StatelessWidget {
  final CAD = Get.put(ColorsClass());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: ThemeData(
          primaryColor: CAD.colorBackground.value,
        ),
        debugShowCheckedModeBanner: false,
        home: enteringPage(),
      );
    });
  }
}
