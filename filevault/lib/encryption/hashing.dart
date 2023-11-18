import 'dart:convert';

import 'package:crypto/crypto.dart';

String getHash(String salt, String text) {
  final bytesText = Utf8Codec().encode(salt + text + salt);
  print("bytesText = $bytesText");
  String t = sha256.convert(bytesText).toString();
  print("hashed = $t");
  return t;
}
