import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:file_selector/file_selector.dart';

void encryptFiles(List<XFile> files, String key, String pathOutput) {
  print("start encrypt");
  var filesInBytes = List<List<int>>.empty(growable: true);
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  final iv = encrypt.IV.fromLength(16);

  filesInBytes.add(iv.bytes);
  files.forEach((element) {
    try {
      final contents = File(element.path).readAsBytesSync();
      final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
      // final encryptedContents = encrypter.encryptBytes(contents, iv: iv);
      // print("contents = ${contents.toString()}");
      final encryptedContents = encrypter.encryptBytes(contents, iv: iv);
      final encryptedPath = pathOutput +
          '\\' +
          element.name.replaceAll('.', '_encryptedByKavarera.');
      // File(encryptedPath).writeAsBytesSync(encryptedContents.bytes);
      filesInBytes.add(encryptedContents.bytes);

      // print(filesInBytes[a]);
      print("encrypt selesai $encryptedPath");
    } catch (e) {
      print("key raw = $key");
      print("keyencrypted = ${keyFrom.length}");
      print("error while encrypting = $e");
    }
  });
  if (filesInBytes.length != 0) {
    String jsonData = json.encode(filesInBytes);
    File(pathOutput + '\\' + 'Encrypted Vault.kvault')
        .writeAsStringSync(jsonData);
  }
}

List<List<int>> decryptFile(String pathOutput, String key) {
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  //TESTING BACA FILE FORMATED JSON
  String contentVault = File(pathOutput).readAsStringSync();
  List<List<int>> data = (json.decode(contentVault) as List)
      .map((list) => List<int>.from(list))
      .toList();
  //decrypt sendiri
  encrypt.IV currentIV = encrypt.IV(Uint8List.fromList(data[0]));
  List<List<int>> decryptedFiles = List.empty(growable: true);
  data.forEach(
    (element) {
      if (element.length == 16) {
        return;
      } else {
        final currentEncryptedFiles = Uint8List.fromList(element);
        final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
        final decryptedContents = encrypter.decryptBytes(
            encrypt.Encrypted(currentEncryptedFiles),
            iv: currentIV);
        final decryptedPath = pathOutput +
            '\\' +
            'decrypted2_${DateTime.now().millisecondsSinceEpoch}.jpg';
        decryptedFiles.add(decryptedContents);
        // File(decryptedPath).writeAsBytesSync(decryptedContents);
      }
    },
  );
  print("testing banyak file berhasil, total file = ${decryptedFiles.length}");
  return decryptedFiles;
}
