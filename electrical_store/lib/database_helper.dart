import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL UNIQUE,
            price REAL NOT NULL,
            details TEXT
          );
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getProducts({String? searchQuery}) async {
    final db = await database;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      return await db.query(
        'products',
        where: 'name LIKE ?',
        whereArgs: ['%$searchQuery%'],
      );
    }
    return await db.query('products');
  }

  Future<int> addProduct(String name, double price, String details) async {
    final db = await database;
    return await db.insert(
      'products',
      {'name': name, 'price': price, 'details': details},
    );
  }

  Future<int> deleteProduct(String name) async {
    final db = await database;
    return await db.delete('products', where: 'name = ?', whereArgs: [name]);
  }

  Future<int> updateProduct(
      String oldName, String newName, double price, String details) async {
    final db = await database;
    return await db.update(
      'products',
      {'name': newName, 'price': price, 'details': details},
      where: 'name = ?',
      whereArgs: [oldName],
    );
  }
}
