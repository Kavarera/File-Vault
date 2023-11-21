import 'package:filevault/controllers/file_decrypt_controller.dart';
import 'package:filevault/controllers/file_encrypt_controller.dart';
import 'package:filevault/utils/hex_color.dart';
import 'package:filevault/widgets/files_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileDecryptPage extends StatelessWidget {
  const FileDecryptPage({super.key});

  @override
  Widget build(BuildContext context) {
    var fileDecryptController = Get.put(FileDecryptController());
    var keyDecryptController = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor("#F0F0F0"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide.none),
                          hintText: fileDecryptController.getLokasi(),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: IconButton(
                  onPressed: () {
                    fileDecryptController.setLokasi();
                  },
                  icon: const Icon(
                    Icons.file_upload,
                    size: 50,
                  ),
                  tooltip: "Choose file vault",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  return TextField(
                    controller: keyDecryptController,
                    decoration: InputDecoration(
                      enabled: fileDecryptController.isLokasiSetup.value,
                      filled: true,
                      fillColor: HexColor("#F0F0F0"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Insert Key For Open The Vault",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    fileDecryptController.testDecryptFileData(
                        keyDecryptController.text.toString());
                    print(fileDecryptController.isDecrypted.value);
                  },
                  child: Text("Decrypt"),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                child: Obx(
                  () {
                    return Visibility(
                      visible: fileDecryptController.isDecrypted.value,
                      child: ElevatedButton(
                          onPressed: () {
                            fileDecryptController.exportAll();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(HexColor("#00658A")),
                          ),
                          child: const Text(
                            "Export All",
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                ),
                child: Obx(
                  () {
                    if (fileDecryptController.isDecrypted.value) {
                      if (fileDecryptController
                          .widgetListDecryptedFile.isNotEmpty) {
                        return GridView.builder(
                          itemCount: fileDecryptController
                              .widgetListDecryptedFile.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 2,
                            crossAxisCount: 8,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                fileDecryptController
                                    .widgetListDecryptedFile[index],
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueAccent),
                                  ),
                                  child: const Text(
                                    "Export",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Text(
                          "Empty Vault :/",
                          style: TextStyle(
                            fontSize: 60,
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: Icon(
                          Icons.lock,
                          size: 400,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
