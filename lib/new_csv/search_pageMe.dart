import "package:flutter/material.dart";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSV Flutter App',
      home: SearchPageMe(),
    );
  }
}

class SearchPageMe extends StatefulWidget {
  const SearchPageMe({super.key});

  @override
  State<SearchPageMe> createState() => _SearchPageMeState();
}

class _SearchPageMeState extends State<SearchPageMe> {
  List<Map<String, String>> dataList = [];
  Future<void> loadData() async {
    String data =
        await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
    List<String> lines = LineSplitter.split(data).toList();
    List<Map<String, String>> newDataList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> cells = lines[i].split(',');
      Map<String, String> item = {
        "footnote": cells[0],
        "description": cells[1],
        "name": cells[2]
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
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              width: 500,
              height: 600,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: Text(dataList[index]["name"]!),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: dataList.length),
            ),
          ],
        ),
      ),
    );
  }
}
