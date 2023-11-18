import 'package:filevault/controllers/login_controller.dart';
import 'package:filevault/routes/route_name.dart';
import 'package:filevault/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  bool _obscureText = true;
  bool _loginIsSuccess = false;
  final LoginController loginController = Get.find();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      onEnd: () {
        if (loginController.user != null) {
          Get.offAllNamed(RouteName.mainPage);
        }
      },
      duration: const Duration(milliseconds: 1500),
      width: _loginIsSuccess ? 0 : 1000,
      height: _loginIsSuccess ? 0 : 380,
      color: Colors.transparent,
      curve: Curves.fastOutSlowIn,
      child: Container(
        constraints: const BoxConstraints(minWidth: 500, maxWidth: 800),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _loginIsSuccess
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.5), // Warna dan opasitas bayangan
              spreadRadius: 3, // Meratakan bayangan
              blurRadius: 4, // Tingkat keburaman bayangan
              offset: const Offset(0, 10), // Posisi bayangan
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Visibility(
          visible: !_loginIsSuccess,
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
                        "Masuk",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#52D14E"),
                        ),
                      ),
                      const Text(
                        "Masukan detail login untuk melanjutkan",
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
                          controller: passwordController,
                          obscureText: _obscureText,
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
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: _obscureText
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
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
                            await loginController.getUserFromDB(
                                usernameController.text,
                                passwordController.text);
                            if (loginController.isLogin.value) {
                              setState(() {
                                _loginIsSuccess = true;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Masuk",
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
                                Get.toNamed(RouteName.register);
                              },
                              child: Text("Daftar Disini")),
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
