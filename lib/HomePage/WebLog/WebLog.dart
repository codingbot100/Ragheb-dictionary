import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ragheb_dictionary/HomePage/WebLog/WebDetail.dart';
import 'package:ragheb_dictionary/Setting/data/fontFamilyDataBase.dart';
import 'package:ragheb_dictionary/Setting/data/sliderData.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/ThemeDatabase.dart';
import 'package:ragheb_dictionary/Tools_Menu/CarouselSlider/tools/themeData.dart';

class message extends StatefulWidget {
  @override
  _messageState createState() => _messageState();
}

class _messageState extends State<message> {
  ThemeDatabase themeDatabase = ThemeDatabase();

  List<List<dynamic>> csvData = [];
  ToDodatabase6 db6 = ToDodatabase6();
  ToDoDataBaseFont dbFont = new ToDoDataBaseFont();
  final _meBox = Hive.box('mybox');
  final thememanger = Get.put(ThemeManager());

  @override
  void initState() {
    themeDatabase.loadData();
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
    thememanger.loadData();
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
                  padding: const EdgeInsets.only(bottom: 36),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                          () => Web_Log_Detail(
                                image:
                                    "images2/${imageList[csvData.indexOf(row) % imageList.length]}",
                                title: row[1].toString(),
                                main_Contant: row[0].toString(),
                                csvData: csvData,
                                imageList: imageList,
                                initialPageIndex: csvData.indexOf(row),
                               
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
                        boxShadow: thememanger.themebo.value != true
                            ? [
                                BoxShadow(
                                  spreadRadius: 0,
                                  color: Theme.of(context).shadowColor,
                                  offset: Offset(2, 2),
                                  blurRadius: 8,
                                )
                              ]
                            : [],
                      ),
                      height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
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
