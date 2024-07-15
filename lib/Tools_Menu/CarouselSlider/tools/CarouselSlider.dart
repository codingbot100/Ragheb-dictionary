import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/WebLog/WebDetail.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSlider1 extends StatefulWidget {
  const CarouselSlider1({Key? key}) : super(key: key);

  @override
  _CarouselSlider1State createState() => _CarouselSlider1State();
}

class _CarouselSlider1State extends State<CarouselSlider1> {
  List<List<dynamic>> csvData = [];
  final themeManger = Get.put(ThemeManager());

  final myItems1 = [
    "web_images/1.jpg",
    "web_images/2.jpg",
    "web_images/4.jpg",
    "web_images/5.jpg",
    "web_images/6.jpg",
    "web_images/7.jpg",
    "web_images/8.jpg",
    "web_images/8.jpg",
    "web_images/9.jpg",
    "web_images/8.jpg",
  ];
  final myItems = [
    "1.jpg",
    "2.jpg",
    "4.jpg",
    "5.jpg",
    "6.jpg",
    "7.jpg",
    "8.jpg",
    "8.jpg",
    "9.jpg",
    "8.jpg",
  ];
  int myCurrentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadCsvData();
  }

  Future<void> loadCsvData() async {
    final String csvString = await rootBundle.loadString('assets/web_Log.csv');
    final List<List<dynamic>> parsedCsv =
        CsvToListConverter().convert(csvString);
    setState(() {
      csvData = parsedCsv;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (csvData.isNotEmpty) {
              int tappedIndex = myCurrentIndex % csvData.length;
              Get.to(() => Web_Log_Detail(
                    imageList: myItems,
                    csvData: csvData,
                    image: "images2/${myItems1[tappedIndex % myItems1.length]}",
                    title: csvData[tappedIndex][1].toString(),
                    main_Contant: csvData[tappedIndex][0].toString(),
                    initialPageIndex: tappedIndex,
                  ));
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              items: List.generate(
                myItems.length,
                (index) => _buildImageContainer(
                    index, screenWidth * 50, screenheight * 20),
              ),
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.linear,
                animateToClosest: true,
                viewportFraction: 1.0,
                enlargeFactor: BorderSide.strokeAlignOutside,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 20 / 8
                //screenheight * 110,
                ,

                onPageChanged: (index, reason) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
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
                  dotHeight: 5,
                  dotWidth: 10,
                  activeDotColor: Color.fromRGBO(0, 150, 137, 1),
                  dotColor: themeManger.themebo.value
                      ? Color.fromRGBO(82, 82, 82, 1)
                      : Colors.white),
              curve: Curves.easeInBack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(int index, double width, double height) {
    return Container(
      height: height,
      width: width, // Ensure the image takes full width

      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          myItems1[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
