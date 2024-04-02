import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/p/incrementController.dart';

// main() {
//   runApp(MeApp());
// }

// class MeApp extends StatefulWidget {
//   MeApp({super.key});

//   @override
//   State<MeApp> createState() => _MeAppState();
// }

// class _MeAppState extends State<MeApp> {
//   final incrementController = Get.put(IncrementController());

//   late ThemeData theme = ThemeData.dark();

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: incrementController.currentMode.value
//           ? ThemeMode.dark
//           : ThemeMode.light,
//       home: Scaffold(
//         body: Center(
//           child: Column(
//             children: [
//               Obx(
//                 () => Column(
//                   children: [
//                     Text("${incrementController.current.value}"),
//                     Text("${incrementController.currentMode.value}"),
//                   ],
//                 ),
//               ),
//               TextButton(
//                   onPressed: () {
//                     incrementController.incrementme();
//                   },
//                   child: Text("Click")),
//               TextButton(
//                   onPressed: () {
//                     Get.to(() => MeApp2());
//                   },
//                   child: Text("go to second page")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MeApp2 extends StatelessWidget {
//   MeApp2({super.key});
//   final incrementController = Get.put(IncrementController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Obx(
//               () => Column(
//                 children: [
//                   Text("${incrementController.current.value}"),
//                   Text("${incrementController.currentMode.value}"),
//                   TextButton(
//                       onPressed: () {
//                         incrementController.incrementme();
//                       },
//                       child: Text("click")),
//                   TextButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: Text("go to second page")),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

void main() {
  final themeController = Get.put(ThemeController());
  runApp(
    Obx(
      () => GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:
            themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: YourHomePage(),
      ),
    ),
  );
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}

class YourHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Mode & Light Mode'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            themeController.toggleTheme();
          },
          child: Text('Switch Theme'),
        ),
      ),
    );
  }
}
