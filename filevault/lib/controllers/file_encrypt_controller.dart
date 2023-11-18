import 'package:file_selector/file_selector.dart';
import 'package:filevault/encryption/aes_encryption.dart';
import 'package:filevault/widgets/files_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileEncryptController extends GetxController {
  XTypeGroup jpgsTypeGroup = const XTypeGroup(
    label: 'JPEGs',
    extensions: <String>['jpg', 'jpeg'],
  );
  XTypeGroup pngTypeGroup = const XTypeGroup(
    label: 'any',
    extensions: <String>['*'],
  );

  var widgetListFile = List<Widget>.empty(growable: true).obs;
  var lokasi = "".obs;
  List<XFile> files = List<XFile>.empty(growable: true);
  Future<void> selectFile({multiple = false}) async {
    files = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      jpgsTypeGroup,
      pngTypeGroup,
    ]);
    files.forEach((element) {
      widgetListFile.add(FileContainer(
        filename: element.name,
      ));
      print(element.name + " path = " + element.path);
    });
  }

  void deleteFile(int index) {
    widgetListFile.removeAt(index);
    files.removeAt(index);
  }

  Future<void> getPath() async {
    final String? tempPath = await getDirectoryPath();
    if (tempPath == null) {
      return;
    }
    lokasi.value = tempPath;
  }

  void startEncrypt(String key) {
    encryptFiles(files, key, lokasi.value);
  }
}
