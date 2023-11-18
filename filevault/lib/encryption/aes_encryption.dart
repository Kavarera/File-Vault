import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:file_selector/file_selector.dart';
import 'package:filevault/models/users.dart';
import 'package:flutter/material.dart';

void encryptFiles(List<XFile> files, String key, String pathOutput) {
  print("start encrypt");
  var filesInBytes = List<int>.empty(growable: true);
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  final iv = encrypt.IV.fromLength(16);
  files.forEach((element) {
    try {
      final contents = File(element.path).readAsBytesSync();
      final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
      // final encryptedContents = encrypter.encryptBytes(contents, iv: iv);
      // print("contents = ${contents.toString()}");
      final encryptedContents = encrypter.encrypt(contents.toString(), iv: iv);

      final encryptedPath = pathOutput +
          '\\' +
          element.name.replaceAll('.', '_encryptedByKavarera.');
      // File(encryptedPath).writeAsBytesSync(encryptedContents.bytes);
      filesInBytes.addAll(encryptedContents.bytes);
      print("encrypt selesai $encryptedPath");
    } catch (e) {
      print("key raw = $key");
      print("keyencrypted = ${keyFrom.length}");
      print("error while encrypting = $e");
    }
  });
  if (filesInBytes.length != 0) {
    File(pathOutput + '\\' + 'Encrypted Vault.kavvault')
        .writeAsBytesSync(Uint8List.fromList(filesInBytes));
  }
}

void decryptFile() {}
