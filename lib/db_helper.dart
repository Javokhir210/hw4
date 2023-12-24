import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;

class DBHelper {
  static Database? dataBase;

  Future<Database> get db async {
    if (dataBase != null) {
      return dataBase!;
    }
    dataBase = await initDatabase();
    return dataBase!;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'temporary_db.db');
    var db = await openDatabase(path, version: 1, onCreate: Create);
    return db;
  }

  void Create(Database db, int version) async {
    await db.execute(
        'CREATE TABLE temporary_db (id INTEGER PRIMARY KEY, name TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert('your_table_name', user.toMap());
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    var result = await dbClient.query('temporary_db');
    return result.map((e) => User.fromMap(e)).toList();
  }
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
