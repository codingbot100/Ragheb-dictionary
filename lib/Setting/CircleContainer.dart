import 'package:flutter/material.dart';

class circleContainer extends StatefulWidget {
  late final circleColor;
  circleContainer({required this.circleColor});

  @override
  State<circleContainer> createState() => _circleContainerState();
}

class _circleContainerState extends State<circleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(100.0)),
    );
  }
}
