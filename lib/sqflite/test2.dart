import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const String dbName = 'raqib_database.db';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(dbName);
    return _database!;
  }

 Future<Database> _initDB(String fileName) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, fileName);

  // Check if the database exists before copying
  if (!await databaseExists(path)) {
    try {
      // Copy the database from assets
      ByteData data = await rootBundle.load('assets/Raqib Database.sql');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      print('Database copied successfully.');
    } catch (e) {
      print('Error copying database: $e');
    }
  } else {
    print('Database already exists.');
  }

  return await openDatabase(path);
}


  // Fetch all rows from the 'raqib' table
  Future<List<Map<String, dynamic>>> fetchAllRows() async {
    final db = await instance.database;
    return await db.query('raqib');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raqib Database',
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
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DatabaseHelper.instance.fetchAllRows();
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raqib Database List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return ListTile(
                  title: Text(item['name'] ?? 'No Name'),
                  subtitle: Text(item['discription'] ?? 'No Description'),
                  trailing: Text(item['favorite'] == 'TRUE' ? 'Favorite' : ''),
                  isThreeLine: true,
                  leading: Text(item['footnote'] ?? 'No Footnote'),
                );
              },
            ),
    );
  }
}
