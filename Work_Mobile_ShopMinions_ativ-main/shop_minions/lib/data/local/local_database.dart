import 'dart:async';
import 'dart:io';

import 'package:shop_minions/model/login.dart';
import 'package:shop_minions/view/login_list/login_list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;

  String tableName = 'usuarios';
  String colID = 'id';
  String colEmail = 'email';
  String colSenha = 'senha';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'minions.db';
    var loginDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return loginDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName ($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colEmail TEXT, $colSenha TEXT) ");
  }

  /* INSERT */
  Future<int> insertlogin(Login login) async {
    Database db = await this.database;
    int result = await db.insert(tableName, login.toMap());
    notify();

    return result;
  }

  //QUERY (SELECT): retorna tudo que tem no BD.

  getLoginList() async {
    Database db = await this.database;
    var loginmaplist = await db.rawQuery('SELECT * FROM $tableName');
    List<Login> loginlist = [];
    List<int> idList = [];
    for (int i = 0; i < loginmaplist.length; i++) {
      Login login = Login.fromMap(loginmaplist[i]);
      login.dataLocation = 1;
      loginlist.add(login);
      idList.add(loginmaplist[i]['id']);
    }
    return [loginlist, idList];
  }

//QUERY (UPDATE):

  Future<int> updateLogin(int loginId, Login login) async {
    Database db = await this.database;
    var result = await db.update(
      tableName,
      login.toMap(),
      where: '$colID = ?',
      whereArgs: [loginId],
    );
    notify();
    return result;
  }

//QUERY (DELETE):
  Future<int> deleteLogin(int loginId) async {
    Database db = await this.database;
    int result =
        await db.rawDelete("DELETE FROM $tableName WHERE  $colID= $loginId");
    notify();
    return result;
  }

  /* 
   STREAM

  */
//NOTIFICA AS COISAS PARA O USUÁRIO.
  notify() async {
    if (_controller != null) {
      var response = await getLoginList();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}

main() {
  var response = DatabaseLocalServer.helper.getLoginList();
  print(response[1]);
}
