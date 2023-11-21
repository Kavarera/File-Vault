import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:filevault/encryption/aes_encryption.dart';
import 'package:filevault/widgets/files_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/file.dart';

class FileDecryptController extends GetxController {
  XTypeGroup vaultFileFormat = const XTypeGroup(
    label: 'Kavarera Vault',
    extensions: <String>['kvault', 'kavvault', 'kavareravault', 'kv'],
  );

  var _lokasi = "Choose Vault File".obs;
  var isLokasiSetup = false.obs;

  var isDecrypted = false.obs;
  List<List<int>>? listDecryptedFile;
  List<FileData>? testListFileData;

  var widgetListDecryptedFile = List<Widget>.empty(growable: true).obs;

  String getLokasi() {
    return _lokasi.value;
  }

  Future<void> exportAnItem(int index) async {
    final String? tempPath = await getDirectoryPath();
    if (tempPath == null) {
      return;
    }
    if (testListFileData != null) {
      if (testListFileData?.length != 0) {
        File(tempPath +
                "\\" +
                DateTime.now().millisecondsSinceEpoch.toString() +
                "_Decrypted_${testListFileData![index].fileName}")
            .writeAsBytesSync(testListFileData![index].content);
        print("file exported");
      }
    }
  }

  void clearItems() {
    if (widgetListDecryptedFile != null) {
      if (widgetListDecryptedFile?.length != 0) {
        widgetListDecryptedFile.clear();
        print("widget clear");
        isDecrypted.value = false;
      }
    }
    if (testListFileData != null) {
      if (testListFileData?.length != 0) {
        testListFileData?.clear();
        print("data clear");
      }
    }
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

  // void startDecrypt(String key) {
  //   print("start decrypt from ${isDecrypted.value} to ${true}");
  //   if (_lokasi.value != "Choose Vault File") {
  //     listDecryptedFile = decryptFile(_lokasi.value, key);
  //     if (listDecryptedFile?.length != 0) {
  //       listDecryptedFile?.forEach((element) {
  //         widgetListDecryptedFile.add(FileContainer(
  //           filename: DateTime.now().millisecondsSinceEpoch.toString(),
  //         ));
  //       });
  //     }
  //     isDecrypted.value = true;
  //   }
  // }

  Future<void> testDecryptFileData(String key) async {
    print("start testing using FileData ${isDecrypted.value} to true");
    try {
      if (_lokasi.value != "Choose Vault File") {
        testListFileData = decryptFileData(_lokasi.value, key);
        if (testListFileData?.length != 0) {
          testListFileData?.forEach((element) {
            widgetListDecryptedFile.add(FileContainer(
              filename: element.fileName,
            ));
          });
        }
        isDecrypted.value = true;
      }
    } catch (e) {
      isDecrypted.value = false;
    }
  }

  Future<void> exportAll() async {
    final String? tempPath = await getDirectoryPath();
    if (tempPath == null) {
      return;
    }
    if (testListFileData != null) {
      if (testListFileData?.length != 0) {
        testListFileData?.forEach((element) {
          File(tempPath +
                  "\\" +
                  DateTime.now().millisecondsSinceEpoch.toString() +
                  "_Decrypted_${element.fileName}")
              .writeAsBytesSync(element.content);
          print("file exported");
        });
      }
    }
  }
}
