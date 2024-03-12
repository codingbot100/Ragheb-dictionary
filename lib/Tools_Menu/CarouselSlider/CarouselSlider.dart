import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSlider1 extends StatefulWidget {
  const CarouselSlider1({Key? key}) : super(key: key);

  @override
  _CarouselSlider1State createState() => _CarouselSlider1State();
}

class _CarouselSlider1State extends State<CarouselSlider1> {
  var colorClass1 = ColorsClass();

  final myItems = [
    'images2/2.jpg',
    'images2/3.jpg',
    'images2/4.jpg',
    'images2/5.jpg',
  ];
  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SingleChildScrollView(
            child: Container(
              child: CarouselSlider(
                items: List.generate(
                  myItems.length,
                  (index) => _buildImageContainer(index),
                ),
                options: CarouselOptions(
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayCurve: Curves.linear,
                  animateToClosest: true,
                  enlargeFactor: BorderSide.strokeAlignOutside,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 9,
            child: AnimatedSmoothIndicator(
              activeIndex: myCurrentIndex,
              count: myItems.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.white,
                dotHeight: 5,
                dotWidth: 10,
              ),
              curve: Curves.easeInBack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(int index) {
    return Container(
      width: 400,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.transparent,
          // width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Image.asset(
          myItems[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
