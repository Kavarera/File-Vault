import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:filevault/encryption/aes_encryption.dart';
import 'package:filevault/widgets/files_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileDecryptController extends GetxController {
  XTypeGroup vaultFileFormat = const XTypeGroup(
    label: 'Kavarera Vault',
    extensions: <String>['kvault', 'kavvault', 'kavareravault', 'kv'],
  );

  var _lokasi = "Choose Vault File".obs;
  var isLokasiSetup = false.obs;

  var isDecrypted = false.obs;
  List<List<int>>? listDecryptedFile;

  var widgetListDecryptedFile = List<Widget>.empty(growable: true).obs;

  String getLokasi() {
    return _lokasi.value;
  }

  Future<void> setLokasi() async {
    var path = await openFile(acceptedTypeGroups: [vaultFileFormat]);
    if (path != null) {
      _lokasi.value = path.path;
      isLokasiSetup.value = true;
      return;
    }
    if (path != "Choose Vault File") {
      isLokasiSetup.value = true;
      return;
    }
    isLokasiSetup.value = false;
  }

  void startDecrypt(String key) {
    print("start decrypt from ${isDecrypted.value} to ${true}");
    if (_lokasi.value != "Choose Vault File") {
      listDecryptedFile = decryptFile(_lokasi.value, key);
      if (listDecryptedFile?.length != 0) {
        listDecryptedFile?.forEach((element) {
          widgetListDecryptedFile.add(FileContainer(
            filename: DateTime.now().millisecondsSinceEpoch.toString(),
          ));
        });
      }
      isDecrypted.value = true;
    }
  }

  Future<void> exportAll() async {
    final String? tempPath = await getDirectoryPath();
    if (tempPath == null) {
      return;
    }
    if (listDecryptedFile != null) {
      if (listDecryptedFile?.length != 0) {
        listDecryptedFile?.forEach((element) {
          File(tempPath +
                  "\\" +
                  DateTime.now().millisecondsSinceEpoch.toString() +
                  ".jpg")
              .writeAsBytesSync(element);
          print("file exported");
        });
      }
    }
  }
}
