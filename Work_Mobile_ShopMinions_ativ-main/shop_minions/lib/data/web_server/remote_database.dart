import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop_minions/model/login.dart';

class DatabaseRemoveServer {
  static DatabaseRemoveServer helper = DatabaseRemoveServer._createInstance();
  DatabaseRemoveServer._createInstance();
  String databaseUrl = "http://192.168.137.1:3000/notes";
  Dio _dio = Dio();

  Future<int> insertlogin(Login login) async {
    await _dio.post(this.databaseUrl,
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({"email": login.email, "senha": login.senha}));
    return 1;
  }

  Future<List<dynamic>> getLoginList() async {
    Response response = await _dio.request(this.databaseUrl,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<Login> loginList = [];
    List<int> idList = [];
    response.data.forEach((element) {
      element["dataLocation"] = 2;
      Login login = Login.fromMap(element);
      loginList.add(login);
      idList.add(element["id"]);
    });
    return [loginList, idList];
  }

  Future<int> updateLogin(int loginId, Login login) async {
    await _dio.put(this.databaseUrl + "/$loginId",
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({"email": login.email, "senha": login.senha}));
    return 1;
  }

  Future<int> deleteLogin(int loginId) async {
    await _dio.delete(this.databaseUrl + "/$loginId",
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    return 1;
  }
}

void main() async {
  DatabaseRemoveServer noteService = DatabaseRemoveServer.helper;
  /*var response = await noteService.getLoginList();
  Login login = response[0][0];
  print(login.email);*/

  Login login = Login();
  login.email = ("aaa@hotmail.com");
  login.senha = ("123");
  // noteService.insertlogin(login);
  //noteService.updateLogin(0, login);
  noteService.deleteLogin(1);
}
