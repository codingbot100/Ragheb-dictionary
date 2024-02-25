import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyData {
  String footnote;
  String description;
  String name;

  MyData(
      {required this.footnote, required this.description, required this.name});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV Flutter App',
      home: homee(),
    );
  }
}

class homee extends StatefulWidget {
  const homee({Key? key}) : super(key: key);

  @override
  State<homee> createState() => _homeeState();
}

class _homeeState extends State<homee> {
  List<Map<String, String>> dataList = [];
  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
    List<String> lines = LineSplitter.split(data).toList();

    List<Map<String, String>> newDataList = [];

    for (int i = 1; i < lines.length; i++) {
      List<String> cells = lines[i].split(",");
      Map<String, String> item = {
        'footnote': cells[0],
        'description': cells[1],
        'name': cells[2],
      };
      newDataList.add(item);
    }

    setState(() {
      dataList = newDataList;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CSV Flutter App'),
      ),
      body: Container(
        width: 300,
        height: 400,
        child: ListView.separated(
          itemCount: dataList.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dataList[index]['name']!,
                  style: TextStyle(fontSize: 14)),
              onTap: () {
                // Handle tap on the ListTile, you can navigate to a new screen or show details here
                // For example, you can use Navigator.push to move to a new screen with detailed information.
              },
            );
          },
        ),
      ),
    );
  }
}
