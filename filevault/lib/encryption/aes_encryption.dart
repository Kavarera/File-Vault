import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:file_selector/file_selector.dart';

import '../models/file.dart';

void encryptFiles(List<XFile> files, String key, String pathOutput) {
  print("start encrypt");
  var filesInBytes = List<List<int>>.empty(growable: true);
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  final iv = encrypt.IV.fromLength(16);
  filesInBytes.add(iv.bytes);

  //Testing dengan FileData
  var fileDatas = List<FileData>.empty(growable: true);

  files.forEach((element) {
    try {
      final contents = File(element.path).readAsBytesSync();
      final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
      final encryptedContents = encrypter.encryptBytes(contents, iv: iv);
      final encryptedPath = pathOutput +
          '\\' +
          element.name.replaceAll('.', '_encryptedByKavarera.');
      filesInBytes.add(encryptedContents.bytes);
      // Menambahkan item ke fileDatas.
      fileDatas.add(FileData(element.name, encryptedContents.bytes));

      print("encrypt selesai $encryptedPath");
    } catch (e) {
      print("key raw = $key");
      print("keyencrypted = ${keyFrom.length}");
      print("error while encrypting = $e");
    }
  });
  // Menambahkan IV ke fileDatas
  fileDatas.add(FileData("sessionEncryptedIV", iv.bytes));

  if (filesInBytes.length != 0) {
    String jsonData = json.encode(filesInBytes);
    // File(pathOutput +
    //         '\\' +
    //         '${DateTime.now().millisecondsSinceEpoch}_Encrypted Vault.kvault')
    //     .writeAsStringSync(jsonData);

    String testPath = pathOutput +
        "\\" +
        "${DateTime.now().millisecondsSinceEpoch}_Kavarera Vault.kvault";
    File(testPath).writeAsStringSync(jsonEncode(fileDatas));
    decryptFileData(testPath, key);
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
        // final decryptedPath = pathOutput +
        //     '\\' +
        //     'decrypted2_${DateTime.now().millisecondsSinceEpoch}.jpg';
        decryptedFiles.add(decryptedContents);
        // File(decryptedPath).writeAsBytesSync(decryptedContents);
      }
    },
  );
  print("testing banyak file berhasil, total file = ${decryptedFiles.length}");
  return decryptedFiles;
}

List<FileData> decryptFileData(String pathOutput, String key) {
  final keyFrom = encrypt.Key.fromUtf8(key.padRight(32));
  // TESTING BACA FILE FORMATED JSON
  String contentVault = File(pathOutput).readAsStringSync();
  dynamic decodedJson = jsonDecode(contentVault);

  List<Map<String, dynamic>> jsonList =
      (decodedJson is List) ? List<Map<String, dynamic>>.from(decodedJson) : [];
  List<FileData> fileDataList =
      jsonList.map((jsonMap) => FileData.fromJson(jsonMap)).toList();
  List<FileData> decryptedFiles = List<FileData>.empty(growable: true);
  encrypt.IV currentIV =
      encrypt.IV(Uint8List.fromList(fileDataList.last.content));
  fileDataList.forEach((element) {
    if (element.fileName == "sessionEncryptedIV") {
      return;
    } else {
      final currentEncryptedFile = Uint8List.fromList(element.content);
      final encrypter = encrypt.Encrypter(encrypt.AES(keyFrom));
      final decryptedContents = encrypter
          .decryptBytes(encrypt.Encrypted(currentEncryptedFile), iv: currentIV);

      // final decryptedPath = pathOutput +
      //       '\\' +
      //       '${DateTime.now().millisecondsSinceEpoch}_${element.fileName}';
      decryptedFiles.add(FileData(element.fileName, decryptedContents));
    }
  });
  return decryptedFiles;
}
