import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../page/file_encrypt_page.dart';

class FileVaultController extends GetxController {
  var _isVaultOpen = false.obs;

  bool getVaultStatus() => _isVaultOpen.value;

  void setVaultStatus(bool value) {
    _isVaultOpen.value = value;
  }

  Widget getCurrentPage() =>
      _isVaultOpen.value ? const Text("false") : FileEncryptPage();
}
