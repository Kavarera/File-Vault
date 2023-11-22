import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

String encryptCaesar(String text, int shift) {
  StringBuffer result = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);

    int encryptedChar = (charCode + shift) % 256;
    // print("${text[i]} -- ${String.fromCharCode(encryptedChar)}");
    result.write(String.fromCharCode(encryptedChar));
  }
  return result.toString();
}

String decryptCaesar(String text, int shift) {
  StringBuffer result = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    int charCode = text.codeUnitAt(i);

    int decryptedChar = (charCode - shift) % 256;
    // print("${text[i]} -- ${String.fromCharCode(decryptedChar)}");

    result.write(String.fromCharCode(decryptedChar));
  }

  return result.toString();
}

String encryptRC4(String plaintext, String key) {
  final keyBytes = utf8.encode(key);
  print(keyBytes);
  final rc4 = RC4Engine()
    ..init(true, KeyParameter(Uint8List.fromList(keyBytes)));

  final plaintextBytes = utf8.encode(plaintext);
  final ciphertextBytes = rc4.process(Uint8List.fromList(plaintextBytes));

  return base64Encode(ciphertextBytes);
}

String decryptRC4(String ciphertext, String key) {
  final keyBytes = utf8.encode(key);
  print(keyBytes);
  final rc4 = RC4Engine()
    ..init(true, KeyParameter(Uint8List.fromList(keyBytes)));

  final ciphertextBytes = base64Decode(ciphertext);
  final decryptedBytes = rc4.process(Uint8List.fromList(ciphertextBytes));

  return utf8.decode(decryptedBytes);
}
