import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:filevault/encryption/aes_encryption.dart';
import 'package:filevault/widgets/files_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/random_facts.dart';
import '../utils/random_images.dart';

class FileEncryptController extends GetxController {
  XTypeGroup imagesTypeGroup = const XTypeGroup(
    label: 'Images',
    extensions: <String>['jpg', 'jpeg', 'png'],
  );
  XTypeGroup documentsTypeGroup = const XTypeGroup(
    label: 'Documents',
    extensions: <String>[
      'docx',
      'doc',
      'pdf',
      'xlsx',
      'xls',
      'csv',
      'pptx',
      'ppt',
      'txt',
      'zip',
      'rar',
      'tar',
      'gz'
    ],
  );
  XTypeGroup codingTypeGroup = const XTypeGroup(
    label: 'Coding File',
    extensions: <String>[
      'cpp',
      'kt',
      'dart',
      'java',
      'py',
      'lua',
      'html',
      'css',
      'js',
      'md',
      'gitignore',
      'ipynb',
      'xml',
      'sql',
      'ddl',
      'yaml',
      'yml',
      'properties',
      'c',
      'sh',
      'log',
      'bat',
    ],
  );
  XTypeGroup anyTypeGroup = const XTypeGroup(
    label: 'any',
    extensions: <String>['*'],
  );

  var onEncrypt = false.obs;

  var widgetListFile = List<Widget>.empty(growable: true).obs;
  var lokasi = "".obs;
  List<XFile> files = List<XFile>.empty(growable: true);
  Future<void> selectFile({multiple = false}) async {
    files = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      imagesTypeGroup,
      documentsTypeGroup,
      codingTypeGroup,
      anyTypeGroup
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

  void clearLoadedData() {
    if (widgetListFile.length > 0) {
      if (files.length > 0) {
        files.clear();
        widgetListFile.clear();
      }
    }
  }

  Future<void> getPath() async {
    final String? tempPath = await getDirectoryPath();
    if (tempPath == null) {
      return;
    }
    lokasi.value = tempPath;
  }

  Future<void> startEncrypt(String key) async {
    await encryptFiles(files, key, lokasi.value);
    await Future.delayed(
      Duration(seconds: 10),
      () {
        print("startEncrypt selesai");
      },
    );
  }
}
