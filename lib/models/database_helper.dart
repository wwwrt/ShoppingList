// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('products.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE products (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         quantity REAL,
//         price REAL
//         listId INTEGER
//       )
//     ''');
//   }

//   Future<void> insertProduct(Map<String, dynamic> product) async {
//     final db = await instance.database;
//     await db.insert('products', product);
//   }

//   Future<List<Map<String, dynamic>>> getProducts(int listId) async {
//     final db = await instance.database;
//     return await db.query('products', where: 'listId = ?', whereArgs: [listId]);
//   }

//   Future<void> deleteProduct(int id) async {
//     final db = await instance.database;
//     await db.delete('products', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<void> updateProduct(int id, Map<String, dynamic> product) async {
//     final db = await instance.database;
//     await db.update('products', product, where: 'id = ?', whereArgs: [id]);
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
