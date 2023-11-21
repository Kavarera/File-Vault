import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:filevault/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/hex_color.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final RegisterController registerController = Get.put(RegisterController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  bool _registerIsDone = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      onEnd: () {
        Get.back();
      },
      duration: const Duration(milliseconds: 1500),
      width: _registerIsDone ? 0 : 1000,
      height: _registerIsDone ? 0 : 480,
      color: Colors.transparent,
      curve: Curves.fastOutSlowIn,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.grey.withOpacity(0.5), // Warna dan opasitas bayangan
                spreadRadius: 3, // Meratakan bayangan
                blurRadius: 4, // Tingkat keburaman bayangan
                offset: const Offset(0, 10),
              )
            ]),
        constraints: const BoxConstraints(minWidth: 600, maxWidth: 900),
        child: Visibility(
          visible: !_registerIsDone,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#52D14E"),
                        ),
                      ),
                      const Text(
                        "Masukan detail pengguna untuk melanjutkan",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: HexColor("#F0F0F0"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Masukan Username",
                              hintStyle: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: password1Controller,
                          obscureText: _obscureText1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor("#F0F0F0"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Masukan Password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                              icon: _obscureText1
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: password2Controller,
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor("#F0F0F0"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Konfirmasi Password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                              icon: _obscureText2
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(
                                40), // fromHeight use double.infinity as width and 40 is the height
                            backgroundColor: HexColor("#52D14E"),
                          ),
                          onPressed: () async {
                            if (password1Controller.text.isNotEmpty &&
                                usernameController.text.isNotEmpty) {
                              if ((password1Controller.text ==
                                      password2Controller.text) &&
                                  usernameController.text.isNotEmpty) {
                                await registerController.register(
                                    usernameController.text.toString(),
                                    password1Controller.text.toString());

                                if (registerController.isRegistered.value) {
                                  await Future.delayed(
                                      Duration(milliseconds: 500));
                                  setState(() {
                                    _registerIsDone = true;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Failed to Register',
                                        message: 'Terjadi kesalahan',

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,
                                      ),
                                    ));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Failed to Register',
                                      message:
                                          "Data Kosong atau password tidak sama",

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.failure,
                                    ),
                                  ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Failed to Register',
                                    message: 'Data Kosong',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                ));
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Daftar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("Masuk Disini")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Image.asset("assets/images/kavlogo.jpg"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
