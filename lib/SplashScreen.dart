import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ragheb_dictionary/Search/DataBase/splashData.dart';

void main(List<String> args) {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                 height: 500,
                width: double.infinity,
                child: Image.asset(
                 
                  
                  color: Colors.transparent,
                  fit: BoxFit.cover,
                  'Image_WelcomPage/s_image.png',
                ),
              ),
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
      ),
    );
  }
}

// 