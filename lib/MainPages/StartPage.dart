// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/MainPages/EnterAnimation.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  var box = await Hive.openBox('mybox');
  runApp(start());
}

class start extends StatelessWidget {
  final CAD = Get.put(ColorsClass());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          backgroundColor: Color(0xFFF5F5DC),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFF5F5DC),
          )),
      debugShowCheckedModeBanner: false,
      home: enteringPage(),
    );
  }
}
