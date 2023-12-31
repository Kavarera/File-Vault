import 'dart:async';

import 'package:filevault/database/database_instance.dart';
import 'package:flutter/material.dart';

import '../utils/hex_color.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#C8D8E4"),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kavarera File Vault",
              style: TextStyle(
                fontSize: 60,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: FutureBuilder(
                future: _initDatabaseInstance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    print("koneksi snapshot sukses");
                    return LoginFormWidget();
                  } else {
                    print("Menunggu");
                    return Text("Menghubungkan Database");
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text("Programmed by Rafli Iskandar Kavarera | 123210131"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initDatabaseInstance() async {
    final database = DatabaseInstance.getInstance();
    try {
      await database.getConnection();
    } catch (e) {
      print('Error inisialisasi database: $e');
    }
    print("database terinisialisasi");
  }
}
