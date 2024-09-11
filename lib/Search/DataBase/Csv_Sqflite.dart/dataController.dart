import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ragheb_dictionary/Search/DataBase/Csv_Sqflite.dart/databaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class DataController extends GetxController {
  var dataList = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDataFromDatabase();
  }

  Future<void> loadDataFromCSV() async {
    try {
      String data = await rootBundle.loadString('assets/Raqib Database - Sheet1 (2).csv');
      List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

      List<Map<String, String>> newDataList = [];
      for (int i = 1; i < csvTable.length; i++) {
        List<dynamic> row = csvTable[i];
        if (row.length < 4) {
          print("Skipping row $i: not enough columns");
          continue;
        }
        Map<String, String> item = {
          "footnote": row[0].toString(),
          "description": row[1].toString(),
          "name": row[2].toString(),
          "favorites": row[3].toString()
        };
        newDataList.add(item);
      }

      // Insert data into SQLite
      await DatabaseHelper.instance.insertData(newDataList);
      await loadDataFromDatabase(); // Reload data from the database

    } catch (e) {
      print("Error loading CSV data: $e");
    }
  }

  Future<void> loadDataFromDatabase() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> queryResult = await db.query(DatabaseHelper.table);
    dataList.value = queryResult.map((row) => row.map((key, value) => MapEntry(key, value.toString()))).toList();
  }
}
