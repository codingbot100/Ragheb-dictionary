import 'package:flutter/material.dart';

main() {
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
                child: Column(
      children: [
        Image.asset(
          'images/Book.png',
          height: 200,
          width: 200,
        ),
        Text(
          'فرهنگ لغت راغب ',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(
                  0, 150, 136, 1) // Adjust font size based on screen width
              ),
        ),
        Container(
          width: MediaQuery.of(context).size.width *
              0.8, // Adjust container width based on screen width
          height: MediaQuery.of(context).size.height *
              0.3, // Adjust container height based on screen height
          color: Colors.blue,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'Responsive Container',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ))));
  }
}
