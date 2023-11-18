import 'package:filevault/controllers/login_controller.dart';
import 'package:filevault/page/login.dart';
import 'package:filevault/routes/page_route.dart';
import 'package:filevault/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Vault Encryption',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: HexColor("#C8D8E4")),
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily),
      home: const LoginPage(),
      getPages: ListPageRoute.pages,
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    );
  }
}
