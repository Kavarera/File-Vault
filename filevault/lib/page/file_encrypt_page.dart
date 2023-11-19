import 'package:filevault/controllers/file_encrypt_controller.dart';
import 'package:filevault/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileEncryptPage extends StatefulWidget {
  const FileEncryptPage({super.key});

  @override
  State<FileEncryptPage> createState() => _FileEncryptPageState();
}

class _FileEncryptPageState extends State<FileEncryptPage> {
  var fileEncryptController = Get.put(FileEncryptController());

  var keyController = TextEditingController();
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
                    onPressed: () {
                      print(fileEncryptController.widgetListFile.length);
                      if (fileEncryptController.widgetListFile.length > 0) {
                        fileEncryptController
                            .startEncrypt(keyController.text.toString());
                        // fileEncryptController
                        //     .readFileVault(fileEncryptController.lokasi.value);
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
                            crossAxisCount: 10,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 2,
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
}
