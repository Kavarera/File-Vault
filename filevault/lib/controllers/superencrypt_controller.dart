import 'package:filevault/encryption/superencrypt.dart';
import 'package:get/get.dart';

class SuperEncryptController extends GetxController {
  String startEncrypt(String raw, String key, int shift) {
    return encryptRC4(encryptCaesar(raw, shift), key);
  }

  String startDecrypt(String raw, String key, int shift) {
    return decryptCaesar(decryptRC4(raw, key), shift);
  }
}
