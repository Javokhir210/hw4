import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'your_database_name.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE your_table_name (id INTEGER PRIMARY KEY, name TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert('your_table_name', user.toMap());
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    var result = await dbClient.query('your_table_name');
    return result.map((e) => User.fromMap(e)).toList();
  }

// Other methods for CRUD operations
}

class User {
  int? id;
  String name;

  User(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(map['id'] as int?, map['name'] as String);
  }
}
