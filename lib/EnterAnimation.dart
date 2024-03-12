import 'package:flutter/material.dart';
import 'package:ragheb_dictionary/HomePage/Navigator.dart';



class enteringPage extends StatefulWidget {
  @override
  _enteringPageState createState() => _enteringPageState();
}

class _enteringPageState extends State<enteringPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Create an opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap your widget with a FadeTransition
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: MyAppNavigator(), // Replace 'YourWidget' with your actual widget
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
