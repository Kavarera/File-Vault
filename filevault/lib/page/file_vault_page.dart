import 'package:filevault/controllers/file_vault_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileVaultPage extends StatelessWidget {
  FileVaultPage({super.key});

  var _fileVaultController = Get.put(FileVaultController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "File Vault",
                  style: TextStyle(fontSize: 30),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        "Open Vault",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Obx(() {
                        return Switch(
                            value: _fileVaultController.getVaultStatus(),
                            onChanged: (value) {
                              _fileVaultController.setVaultStatus(value);
                            });
                      }),
                    )
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => _fileVaultController.getCurrentPage(),
            ),
          )
        ],
      ),
    );
  }
}
