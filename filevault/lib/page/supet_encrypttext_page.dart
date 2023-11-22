import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:clipboard/clipboard.dart';
import 'package:filevault/controllers/superencrypt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/hex_color.dart';

class SuperEncryptPage extends StatelessWidget {
  const SuperEncryptPage({super.key});
  @override
  Widget build(BuildContext context) {
    final rawTextController = TextEditingController();
    final resultTextController = TextEditingController();
    final shiftController = TextEditingController();
    final keyController = TextEditingController();
    var controller = Get.put(SuperEncryptController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Text Super Encryption",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "Encrypt With Caesar Chipper and RC4",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 15),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: keyController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor("#F0F0F0"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Key (for RC4)",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: TextField(
                            controller: shiftController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter
                                  .digitsOnly // Hanya menerima digit
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: HexColor("#F0F0F0"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Shift (for Caesar Chipper)",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: rawTextController,
                      decoration: InputDecoration(
                        filled: true,
                        suffix: ElevatedButton(
                            onPressed: () {
                              rawTextController.clear();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  HexColor("#1793E0")),
                            ),
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.white),
                            )),
                        fillColor: HexColor("#F0F0F0"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Input Text Here...",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      maxLines: null,
                      minLines: null,
                      expands: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (keyController.text.isNotEmpty &&
                                shiftController.text.isNotEmpty &&
                                rawTextController.text.isNotEmpty) {
                              resultTextController.text =
                                  controller.startEncrypt(
                                      rawTextController.text,
                                      keyController.text,
                                      int.parse(
                                          shiftController.text.toString()));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Failed to Superencrypt',
                                    message:
                                        'Key, Shift dan Text tidak boleh kosong',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                ));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#019EFF")),
                          ),
                          child: const Text(
                            "Encrypt",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (keyController.text.isNotEmpty &&
                                shiftController.text.isNotEmpty &&
                                rawTextController.text.isNotEmpty) {
                              resultTextController.text =
                                  controller.startDecrypt(
                                      rawTextController.text,
                                      keyController.text,
                                      int.parse(
                                          shiftController.text.toString()));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Failed to Superencrypt',
                                    message:
                                        'Key, Shift dan Text tidak boleh kosong',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                ));
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#019EFF")),
                          ),
                          child: const Text(
                            "Decrypt",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: resultTextController,
                      decoration: InputDecoration(
                        filled: true,
                        suffix: ElevatedButton(
                          onPressed: () {
                            FlutterClipboard.controlC(
                                resultTextController.text);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#1793E0")),
                          ),
                          child: const Text(
                            "Copy",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        fillColor: HexColor("#F0F0F0"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Result will be here...",
                        hintStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      maxLines: null,
                      minLines: null,
                      expands: true,
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
