import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/WebLog/WebDetail.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';

class message extends StatefulWidget {
  @override
  _messageState createState() => _messageState();
}

class _messageState extends State<message> {
  List<List<dynamic>> csvData = [];
  ToDodatabase6 db6 = ToDodatabase6();
  ToDoDataBaseFont dbFont = new ToDoDataBaseFont();
  final _meBox = Hive.box('mybox');

  @override
  void initState() {
    if (_meBox.get("TODOSlid") == null) {
      dbFont.createInitialData();
    } else {
      dbFont.loadData();
    }
    if (_meBox.get("FontFamily") == null) {
      db6.createInitialData();
    } else {
      db6.loadData();
    }
    super.initState();
    loadCsvData();
  }

  List<String> imageList = [
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
    return Scaffold(
      // backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: ListTile(
            shape: RoundedRectangleBorder(side: BorderSide.none),
                  tileColor: Colors.transparent,
          trailing: Text(
            'وبلاگ راغب',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Yekan',
              fontWeight: FontWeight.w700,
              // color: Color.fromRGBO(0, 150, 136, 1)
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var row in csvData) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                          () => Web_Log_Detail(
                                image:
                                    "images2/${imageList[csvData.indexOf(row) % imageList.length]}",
                                title: row[1].toString(),
                                main_Contant: row[0].toString(),
                              ),
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 350));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            width: 1),
                        color: Theme.of(context)
                            .colorScheme
                            .background, // boxShadow:
                        // color: Color.fromRGBO(245, 245, 220, 1),
                        // boxShadow: [
                        //   BoxShadow(
                        //     spreadRadius: 0,
                        //     // color: Color.fromRGBO(0, 0, 0, 0.1),
                        //     offset: Offset(2, 2),
                        //     blurRadius: 8,
                        //   )
                        // ]
                      ),
                      height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.asset(
                                "images2/${imageList[csvData.indexOf(row) % imageList.length]}",
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, right: 8),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  textAlign: TextAlign.right,
                                  row[1].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      // color: Colors.black,
                                      fontSize: db6.title_Web_Main,
                                      fontFamily: dbFont.FontFamily),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:ragheb_dictionary/HomePage/WebLog/WebDetail.dart';

// class message extends StatefulWidget {
//   const message({super.key});

//   @override
//   State<message> createState() => _messageState();
// }

// class _messageState extends State<message> {
//   var fontFamile2 = 'YekanBakh';
//   final fontSizeTitle = 20.0;
//   double fontSizeSubTitle = 10.0;
//   final colorPrimary = Color(0xFF009688);
//   final colorBackground = Color.fromRGBO(245, 245, 220, 1);
//   final colorPrimary2 = Color(0xFFB0BEC5);
//   final colorBackground2 = Color.fromARGB(255, 224, 224, 224);
//   var listColor = Color.fromRGBO(0, 150, 136, 1);
//   List<Map<String, String>> dataList = [];

//   Future<void> loadData() async {
//     String data = await rootBundle.loadString('assets/web_Log.csv');
//     List<String> lines = LineSplitter.split(data).toList();
//     List<Map<String, String>> newDataList = [];
//     for (int i = 1; i < lines.length; i++) {
//       List<String> cells = lines[i].split(',');
//       Map<String, String> item = {
//         "main_contant": cells[0],
//         "title": cells[1],
//       };
//       newDataList.add(item);
//     }
//     setState(() {
//       dataList = newDataList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F5DC),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             children: [
//               Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       'وبلاگ راغب',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Yekan',
//                           fontWeight: FontWeight.w700,
//                           color: Color.fromRGBO(0, 150, 136, 1)),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(),
//                 child: SafeArea(
//                   child: SingleChildScrollView(
//                     child: Expanded(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 630,
//                             width: double.infinity,
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: 10,
//                                 itemBuilder: (context, index) {
//                                   final item = dataList[index];
//                                   return Padding(
//                                     padding: const EdgeInsets.only(bottom: 30),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.to(() => Web_Log_Detail(),
//                                             transition: Transition.fadeIn);
//                                       },
//                                       child: Container(
//                                         width: 200,
//                                         decoration: BoxDecoration(
//                                             color: Color.fromRGBO(
//                                                 245, 245, 220, 1),
//                                             borderRadius:
//                                                 BorderRadius.circular(12.0),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   color: Color.fromRGBO(
//                                                       0, 0, 0, 0.08),
//                                                   offset: Offset(2, 2))
//                                             ]),
//                                         height: 350,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(bottom: 10),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               25.0)),
//                                                   width: double.infinity,
//                                                   child: Image.asset(
//                                                       'images2/2.jpg')),
//                                               Container(
//                                                 width: 300,
//                                                 child: RichText(
//                                                     textDirection:
//                                                         TextDirection.rtl,
//                                                     textAlign: TextAlign.right,
//                                                     text: TextSpan(
//                                                       text: item['title'],
//                                                       style: TextStyle(
//                                                         fontFamily: fontFamile2,
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.w900,
//                                                         color: Color.fromRGBO(
//                                                             82, 82, 82, 1),
//                                                       ),
//                                                     )),
//                                               ),
//                                               Container(
//                                                 width: 300,
//                                                 child: RichText(
//                                                     textDirection:
//                                                         TextDirection.rtl,
//                                                     textAlign:
//                                                         TextAlign.justify,
//                                                     text: TextSpan(
//                                                       text:
//                                                           'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد.\n\n'
//                                                           'کتابهای زیادی در شصت و سه درصد گذشته حال .',
//                                                       style: TextStyle(
//                                                         fontFamily: fontFamile2,
//                                                         fontSize: 8,
//                                                         fontWeight:
//                                                             FontWeight.w300,
//                                                         color: Color.fromRGBO(
//                                                             111, 111, 111, 1),
//                                                       ),
//                                                     )),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
