
import 'package:login_actividad3/JSON/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  final DatabaseName = "database.db";

  Future<Database> initDB()async{
    final Databsepath = await getDatabasesPath();
    final path = join(Databsepath, DatabaseName);

    return openDatabase(path, version: 1,
      onCreate: (db, version) async{
        await db.execute('CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, fullName TEXT, email TEXT, userName TEXT UNIQUE, password TEXT)');
      }
      );
  }

  Future<bool> autenticar(Users usr)async{
    final Database db = await initDB();
    var result = await db.rawQuery("select * from users where userName = '${usr.userName}' AND password = '${usr.password}' ");
    if (result.isNotEmpty) {
      return true;
    }else{
      return false;
    }
  }

  Future<int> createUser(Users usr)async{
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  Future<Users?> getUser(String UserName)async{
    final Database db = await initDB();
    var res = await db.query("users", where: "userName = ?", whereArgs: [UserName]);
    return res.isNotEmpty? Users.fromMap(res.first):null;
  }

  Future<Future<int>> deleteUser(String userName)async{
    final Database db = await initDB();
    return  db.delete("users", where: "userName = ?", whereArgs: [userName]);
  }

  Future<int> updateUser(Users user)async{
    final Database db = await initDB();
    return db.update("users", user.toMap(), where: "userName = ?", whereArgs: [user.userName]);
  }
}
