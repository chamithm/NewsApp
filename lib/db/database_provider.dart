import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  Database? _database;

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  initDB() async{
    return await openDatabase(join(await getDatabasesPath(), "news_app.db"),
        onCreate: (db,version) async{
          await db.execute('''
            CREATE TABLE users(
              id INTEGER,
              username TEXT,
              password TEXT,
              isLogged TEXT,
              creation_date TEXT
            )
          ''');
        }, version: 1
    );
  }

  createUser(Map<String,dynamic> loginDetails) async{
    final db = await database;
    initDB();
    db.insert("users", loginDetails,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  updateUser(Map<String,dynamic> loginDetails) async{
    final db = await database;
    initDB();
    await db.update(
      'users',
      loginDetails,
      where: 'id = 1',
    );
  }

  Future<dynamic> getUser() async{
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM users');
    if(res.isEmpty){
      return null;
    }else{
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : null;
    }
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete("users"); // This deletes all rows in the table
  }
}