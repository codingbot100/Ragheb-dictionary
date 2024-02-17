import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:ragheb_dictionary/HomePage/bottoNavigation.dart';
import 'package:ragheb_dictionary/HomePage/searchPage/InformationPage.dart';

class CardItem {
  late final String title;
  late final String description;
  late final String inititle;
  bool iconState = false;

  CardItem(
      {required this.title,
      required this.description,
      required this.inititle,
      required this.iconState});
}

class Listbar extends StatefulWidget {
  const Listbar({Key? key}) : super(key: key);

  @override
  State<Listbar> createState() => _ListbarState();
}

class _ListbarState extends State<Listbar> {
  List<CardItem> allInfo = [
    CardItem(
        title: 'تقوا',
        description: "یک از صفات مومنان است",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'اخلاص',
        description: "خداوند متعال اشخاص با اخلاص را دوست دارد ",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'شکر',
        description: "باید در هر حال شکر گذار باشیم",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'پاکی',
        description: "اشخاص پاک دامن در نزد الله گرانقدر هستند",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'خلافت',
        description: "خلافت یک امر فرض است",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'تقوا',
        description: "یک از صفات مومنان است",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'اخلاص',
        description: "خداوند متعال اشخاص با اخلاص را دوست دارد ",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'شکر',
        description: "باید در هر حال شکر گذار باشیم",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'پاکی',
        description: "اشخاص پاک دامن در نزد الله گرانقدر هستند",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'خلافت',
        description: "خلافت یک امر فرض است",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'تقوا',
        description: "یک از صفات مومنان است",
        inititle: "ص 2",
        iconState: false),
    CardItem(
        title: 'اخلاص',
        description: "خداوند متعال اشخاص با اخلاص را دوست دارد ",
        inititle: "ص 2",
        iconState: false),
   
  ];

  void message2() {
    setState(() {
      if (searchController != Null) {
        message = "نتیجه جستجو شما";
      } else {
        message = 'جستجوی انجام نه شده ';
      }
    });
  }

  String message = '';

  List<CardItem> filteredInfo = [];

  List<bool> iconStates = List.filled(5, false);

  bool iconbool = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredInfo = allInfo;
    super.initState();

    
  }

  double width = 280.0;
  bool colorsearch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 75, bottom: 40, right: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {
                          Get.to(() => bottm(),
                              curve: Curves.fastEaseInToSlowEaseOut,
                              transition: Transition.leftToRightWithFade,
                              duration: Duration(milliseconds: 1000));
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      width: 310,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: -10.0,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0)),
                      duration: Duration(milliseconds: 300),
                      height: 40,
                      child: Expanded(
                        child: TextField(
                          cursorColor: Colors.black,
                          cursorHeight: 15,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                              fontFamily: 'Yekan',
                              fontSize: 17,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                          controller: searchController,
                          onChanged: (value) {
                            filterList(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                              icon: Icon(Icons.clear),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  colorsearch = !colorsearch;
                                });
                              },
                              icon: Icon(Icons.search, color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(message),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                    position: 1,
                    duration: Duration(milliseconds: 500),
                    child: SlideAnimation(
                        verticalOffset: 200.0,
                        child: FadeInAnimation(
                            child: Padding(
                                padding: EdgeInsets.all(3),
                                child: buildList(filteredInfo[index])))));
              },
              itemCount: filteredInfo.length,
            )),
          ],
        ),
      ),
    );
  }

  Widget buildList(CardItem info) => GestureDetector(
        onTap: () {
          print('Tapped on item: ${info.title}');

          Get.to(() => InformationPage(),
              transition: Transition.rightToLeftWithFade,
              curve: Curves.fastEaseInToSlowEaseOut,
              duration: Duration(milliseconds: 1000));
        },
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 50,
              child: Center(
                child: Card(
                  color: Color(0xFFF5F5DC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    hoverColor: Colors.transparent,
                    title: Text(
                      info.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  void filterList(String query) {
    setState(() {
      filteredInfo = allInfo
          .where(
              (info) => info.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}





//  Widget buildList(CardItem info) => GestureDetector(
//         onTap: () {
//           print('Tapped on item: ${info.title}');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => infopage(),
//             ),
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: Container(
//               height: 50,
//               child: Center(
//                 child: Card(
//                   color: Color(0xFFF5F5DC),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     hoverColor: Colors.transparent,
//                     title: Text(
//                       info.title,
//                       textAlign: TextAlign.right,
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//   void filterList(String query) {
//     setState(() {
//       filteredInfo = allInfo
//           .where(
//               (info) => info.title.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
// }
