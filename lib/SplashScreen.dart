
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  'Image_WelcomPage/Main Logo.svg',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'فرهنگ لغت راغب ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "YekanBakh",
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(0, 150, 136, 1),
                  ),
                ),
              ),
            ],
          ),
        )),
      
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;
  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration:
              Duration(milliseconds: 500), // Custom transition duration
        );
}
