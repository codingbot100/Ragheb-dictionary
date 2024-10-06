// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//             child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 500,
//                 width: double.infinity,
//                 child: Image.asset(
//                   'svg_images/s_image.png',
//                   color: Colors.transparent,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: SvgPicture.asset(
//                   'svg_images/Main Logo.svg',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 50),
//                 child: Text(
//                   'فرهنگ لغت راغب ',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontFamily: "YekanBakh",
//                     fontWeight: FontWeight.w900,
//                     color: Color.fromRGBO(0, 150, 136, 1),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';
import 'package:ragheb_dictionary/Setting/welcome_screen/Phone_screen.dart';
import 'package:ragheb_dictionary/Setting/welcome_screen/Tablet_Screen.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';

class SplashScreen_Animated extends StatefulWidget {
  SplashScreen_Animated({super.key});

  @override
  State<SplashScreen_Animated> createState() => _SplashScreen_AnimatedState();
}

class _SplashScreen_AnimatedState extends State<SplashScreen_Animated> {
  final splash = Get.put(splashclass());
  @override
  void initState() {
    splash.checkPage = false.obs;
    super.initState();
  }
  final ThemeManager themeManager = Get.put(ThemeManager());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    return SafeArea(
      child: AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: height * 0.73, // Use a proportion of the screen height
                child: Image.asset(
                  "svg_images/s_image.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.03), // Proportional padding
                child: SvgPicture.asset(
                  'svg_images/Main Logo.svg',
                  height: height * 0.09,
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(0, 150, 136, 1),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02), // Proportional padding
                child: Text(
                  'فرهنگ لغت راغب ',
                  style: TextStyle(
                    fontSize: isTablet ? 40 : 24,
                    fontFamily: "YekanBakh",
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        nextScreen: Obx(() {
          // Check if the device is a tablet based on screen width
          bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;

          if (!splash.checkPage.value) {
            splash.setWelcomeScreenShown();
            // Show the appropriate screen based on the device type
            return isTablet ? TabletWelcomScreen() : PhoneWelcomeScreen();
          } else {
            return MyAppNavigator();
          }
        }),

        backgroundColor: themeManager.themebo.value
            ? Color.fromRGBO(33, 33, 33, 1)
            : Color.fromRGBO(245, 245, 220, 1),

        splashIconSize: double.infinity,
        duration: 1000, // Adjust as needed
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: Duration(seconds: 1),
      ),
    );
  }
}
