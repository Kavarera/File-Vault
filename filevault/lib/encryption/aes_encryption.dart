import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:file_selector/file_selector.dart';

void encryptFiles(List<XFile> files, String key, String pathOutput) {
  print("start encrypt");
  var filesInBytes = List<List<int>>.empty(growable: true);
  var filesInBytesRepresentString = List<String>.empty(growable: true);
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  final iv = encrypt.IV.fromLength(16);
  int a = 0;
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

    //TESTING BACA FILE FORMATED JSON
    String contentVault =
        File(pathOutput + '\\' + 'Encrypted Vault.kvault').readAsStringSync();
    List<List<int>> data = (json.decode(contentVault) as List)
        .map((list) => List<int>.from(list))
        .toList();

    //COBA DECRYPT
    //coba save file as bytes dari gpt
    File(pathOutput + '\\' + 'Encrypted Vault.kvault2').writeAsBytesSync(
        Uint8List.fromList(filesInBytes.expand((x) => x).toList()));

    //Baca file as bytes
    final encryptedContent =
        File(pathOutput + '\\' + 'Encrypted Vault.kvault2').readAsBytesSync();
    final encryptedFiles = [encryptedContent];
    print(encryptedFiles.length);
    encryptedFiles.forEach((element) {
      try {
        final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
        final decryptedContents =
            encrypter.decryptBytes(encrypt.Encrypted(element), iv: iv);
        final decryptedPath = pathOutput +
            '\\' +
            'decrypted_${DateTime.now().millisecondsSinceEpoch}.jpg';
        File(decryptedPath).writeAsBytesSync(decryptedContents);
        print("decrypt selesai $decryptedPath");
      } catch (e) {
        print("error while decrypting = $e");
      }
    });
  }
}

void decryptFile() {}
