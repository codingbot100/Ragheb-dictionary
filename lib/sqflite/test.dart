import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class youapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database? _database;
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    // Specify the path to the database
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'Raqib Database.sqlite');

    // Copy the database file from assets to the app's internal storage
    await _copyDatabaseFromAssets(path);

    // Open the database
    _database = await openDatabase(path);

    // Fetch data from the database
    _fetchData();
  }

  Future<void> _copyDatabaseFromAssets(String path) async {
    // Check if the database already exists to avoid overwriting
    bool exists = await databaseExists(path);

    if (!exists) {
      // Load database from assets
      ByteData data = await rootBundle.load('assets/Raqib Database.sqlite.sqbpro');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write the database file to the app's internal storage
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  Future<void> _fetchData() async {
    if (_database == null) return;

    // Fetch data from the 'Raqib' table
    List<Map<String, dynamic>> result = await _database!.query('Raqib');

    // Update the state with the fetched data
    setState(() {
      _data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Data Display'),
      ),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_data[index]['name'] ?? 'No Name'),
                  subtitle: Text(_data[index]['description'] ?? 'No Description'),
                );
              },
            ),
    );
  }
}
