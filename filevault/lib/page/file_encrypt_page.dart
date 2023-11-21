import 'dart:math';

import 'package:filevault/controllers/file_encrypt_controller.dart';
import 'package:filevault/utils/hex_color.dart';
import 'package:filevault/utils/random_facts.dart';
import 'package:filevault/utils/random_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FileEncryptPage extends StatefulWidget {
  const FileEncryptPage({super.key});

  @override
  State<FileEncryptPage> createState() => _FileEncryptPageState();
}

class _FileEncryptPageState extends State<FileEncryptPage>
    with SingleTickerProviderStateMixin {
  var fileEncryptController = Get.put(FileEncryptController());
  var keyController = TextEditingController();
  var _currentImage = Random().nextInt(getTotalRandomPic());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Obx(() {
                  return TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F0F0F0"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: fileEncryptController.lokasi.isEmpty
                          ? "Choose Path"
                          : fileEncryptController.lokasi.value,
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                })),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: IconButton(
                    onPressed: () {
                      fileEncryptController.getPath();
                    },
                    icon: const Icon(
                      Icons.snippet_folder,
                      size: 50,
                    ),
                    tooltip: "Choose path",
                  ),
                ),
              ],
            ),
            Row(
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
                      hintText: "Insert Key",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    onPressed: () async {
                      print(fileEncryptController.widgetListFile.length);
                      if (fileEncryptController.widgetListFile.length > 0) {
                        Get.defaultDialog(
                            barrierDismissible: false,
                            contentPadding: const EdgeInsets.all(0),
                            title:
                                "Sedang Membuat Vault", // Tidak dapat menutup dialog dengan mengklik di luar dialog
                            content: Container(
                              width: 800,
                              height: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LinearProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 300,
                                    child: FadeTransition(
                                      opacity:
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .animate(
                                        CurvedAnimation(
                                          parent:
                                              AlwaysStoppedAnimation<double>(
                                                  1.0),
                                          curve: Interval(0.5, 1.0,
                                              curve: Curves.easeInOut),
                                        ),
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                          getRandomPic(Random()
                                              .nextInt(getTotalRandomPic())),
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  LinearProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Tahukah kamu?",
                                      style: GoogleFonts.poppins(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(getFakta(
                                        Random().nextInt(getTotalFakta()))),
                                  ),
                                ],
                              ),
                            ),
                            titleStyle: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ));
                        await Future.delayed(Duration(seconds: 10));
                        await fileEncryptController
                            .startEncrypt(keyController.text.toString());
                        print("dialog tertutup");
                        Get.back();
                      }
                    },
                    child: Text("Encrypt"),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () async {
                  fileEncryptController.selectFile(multiple: true);
                },
                icon: const Icon(
                  Icons.attach_file,
                  size: 30,
                ),
                tooltip: "Add file",
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    child: Obx(() {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 5),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 8,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                fileEncryptController.widgetListFile[index],
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  onPressed: () {
                                    fileEncryptController.deleteFile(index);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          itemCount:
                              fileEncryptController.widgetListFile.length,
                        ),
                      );
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showEncryptingDialog() async {
    print("dialog terbka");
    Get.defaultDialog(
        barrierDismissible: true,
        contentPadding: const EdgeInsets.all(0),
        title:
            "Sedang Membuat Vault", // Tidak dapat menutup dialog dengan mengklik di luar dialog
        content: Container(
          width: 800,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: AlwaysStoppedAnimation<double>(1.0),
                      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
                    ),
                  ),
                  child: Image(
                    image: AssetImage(
                      getRandomPic(Random().nextInt(getTotalRandomPic())),
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "Tahukah kamu?",
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(getFakta(Random().nextInt(getTotalFakta()))),
              )
            ],
          ),
        ),
        titleStyle: GoogleFonts.poppins(
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ));
  }
}
