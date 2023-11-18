import 'package:filevault/database/database_instance.dart';
import 'package:filevault/encryption/hashing.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../models/users.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;
  User? user;

  Future<void> getUserFromDB(String username, String password) async {
    password = getHash(username, password);
    final database = DatabaseInstance.getInstance();
    final connection = await database.getConnection();
    var result = await connection?.query(
        'SELECT * FROM users WHERE username = ? AND password = ?',
        [username, password]);
    if (result != null && result.isNotEmpty) {
      user = User.fromMap(result.first.fields);
      isLogin.value = true;
      print(user?.username);
    }
  }
}
