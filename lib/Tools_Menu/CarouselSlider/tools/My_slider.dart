import 'package:carousel_slider/carousel_slider.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/WebLog/WebDetail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class My_slider extends StatefulWidget {
  const My_slider({Key? key}) : super(key: key);

  @override
  _My_sliderState createState() => _My_sliderState();
}

class _My_sliderState extends State<My_slider> {
  List<List<dynamic>> csvData = [];
  final themeManger = Get.put(ThemeManager());

  final myItems1 = [
    "web_images/1.jpg",
    "web_images/2.jpg",
    "web_images/3.jpg",
    "web_images/4.jpg",
    "web_images/5.jpg",
    "web_images/6.jpg",
    "web_images/7.jpg",
    "web_images/8.jpg",
    "web_images/9.jpg",
    "web_images/10.jpg",
    "web_images/11.jpg",
    "web_images/13.jpg",
    "web_images/12.jpg",
    "web_images/14.jpg",
    "web_images/14.jpg",
  ];
  final myItems = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
    "5.jpg",
    "6.jpg",
    "7.jpg",
    "8.jpg",
    "9.jpg",
    "10.jpg",
    "11.jpg",
    "13.jpg",
    "12.jpg",
    "14.jpg",
    "14.jpg",
  ];
  late int myCurrentIndex;
  @override
  void initState() {
    myCurrentIndex = 0;

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

    // Define breakpoints for different device types
    bool isTablet = screenWidth > 600; // Example breakpoint for tablets
    if (csvData.isEmpty || myCurrentIndex >= csvData.length) {
      return Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator or a fallback UI
      );
    }

    final row = csvData[myCurrentIndex];
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
                5,
                (index) => _buildImageContainer(
                  index,
                  screenWidth,
                  screenheight * 0.3,
                  csvData.isNotEmpty
                      ? csvData[myCurrentIndex % csvData.length][1].toString()
                      : '',
                  row[0],
                ),
              ),
              options: CarouselOptions(
                height: isTablet ? screenheight * 0.17 : screenheight * 0.12,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                viewportFraction: 1.0,
                autoPlay: true,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
              ),
              // Use the aliased controller
            ),
          ),
        ),
        Container(
          height: 9,
          child: AnimatedSmoothIndicator(
            activeIndex: myCurrentIndex,
            count: 5,
            effect: ExpandingDotsEffect(
                dotHeight: isTablet ? 8 : 5,
                dotWidth: isTablet ? 15 : 10,
                activeDotColor: Color.fromRGBO(0, 150, 137, 1),
                dotColor: themeManger.themebo.value
                    ? Color.fromRGBO(82, 82, 82, 1)
                    : Colors.white),
            curve: Curves.easeInBack,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(
      int index, double width, double height, String title, desciption) {
    return LayoutBuilder(builder: (context, constrans) {
      double screenWidth = constrans.maxWidth;
      double baseWidth = width;

      double scaleFactor = screenWidth / baseWidth;
      double heightScaleFactor = height / height;

      // Define breakpoints for different device types
      bool isTablet = screenWidth > 600; // Example breakpoint for tablets

      return Center(
        child: Container(
          width: screenWidth * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // The background image
              Container(
                width: screenWidth * 0.68,
                height: isTablet
                    ? 180 * heightScaleFactor
                    : 96 * heightScaleFactor, // Adjusted height
                padding:
                    EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: themeManger.themebo.value
                      ? Color.fromRGBO(23, 23, 23, 1)
                      : Color.fromRGBO(224, 224, 191, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        softWrap: true,
                        title,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 150, 136, 1),
                            fontFamily: "YekanBakh",
                            fontSize: isTablet
                                ? 27 * scaleFactor
                                : 12 * scaleFactor, // Adjusted font size
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Text(
                          textDirection: TextDirection.rtl,
                          softWrap: true,
                          overflow: TextOverflow
                              .ellipsis, // This will hide the overflow text with ellipsis
                          maxLines: 3,

                          desciption,
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1),
                              fontFamily: "YekanBakh",
                              fontSize: isTablet
                                  ? 23 * scaleFactor
                                  : 11 * scaleFactor, // Adjusted font size
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.3,
                height: isTablet
                    ? 180 * heightScaleFactor
                    : 96 * heightScaleFactor, // Ad // Adjusted height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage(myItems1[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
