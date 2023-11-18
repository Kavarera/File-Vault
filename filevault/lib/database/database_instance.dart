import 'package:get/get.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  MySqlConnection? _connection;

  static final DatabaseInstance _instance = DatabaseInstance._();

  factory DatabaseInstance.getInstance() {
    return _instance;
  }
  DatabaseInstance._();

  Future<MySqlConnection?> getConnection() async {
    if (_connection == null) {
      final settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        db: 'filevault',
        user: 'root',
      );

      try {
        _connection = await MySqlConnection.connect(settings);
        print("Koneksi berhasil Dibuat");
      } catch (e) {
        print('Error connecting to MySQL: $e');
      }
    }
    return _connection;
  }
}
