import 'package:mysql1/mysql1.dart';

import '../database/database_instance.dart';

class User {
  int id;
  String username;
  String password;

  User({
    required this.id,
    required this.username,
    required this.password,
  });

  // Membuat instance User dari hasil query database
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'].toString(),
    );
  }

  // Mengonversi instance User menjadi Map untuk penyimpanan atau penyimpanan database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  static Future<User?> getUserByUsername(
      String username, MySqlConnection connection) async {
    var results = await connection
        .query('SELECT * FROM users WHERE username = "$username" ');
    if (results.isNotEmpty) {
      return User.fromMap(results.first.fields);
    } else {
      return null;
    }
  }

  Future<void> insertUser() async {
    try {
      final database = DatabaseInstance.getInstance();
      final connection = await database.getConnection();
      connection?.query('INSERT INTO USERS(username,password) VALUES (?,?)',
          [username, password]);
    } catch (e) {
      print("error while insert: $e");
    }
  }
}
