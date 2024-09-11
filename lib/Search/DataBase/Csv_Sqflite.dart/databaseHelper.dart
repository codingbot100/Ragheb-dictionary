import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;
  static final table = 'my_table';

  // Columns
  static final columnId = '_id';
  static final columnFootnote = 'footnote';
  static final columnDescription = 'description';
  static final columnName = 'name';
  static final columnFavorites = 'favorites';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnFootnote TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnFavorites TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertData(List<Map<String, String>> dataList) async {
    Database db = await instance.database;
    Batch batch = db.batch();
    for (var item in dataList) {
      batch.insert(table, item);
    }
    await batch.commit(noResult: true);
  }
}
