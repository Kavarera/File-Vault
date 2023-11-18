import 'package:filevault/page/file_vault_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _currentPage = 0.obs;

  Widget getCurrentPage() {
    switch (_currentPage.value) {
      case 0:
        return FileVaultPage();
      case 1:
        return Text("Super Encrypt Page");
      default:
        return Text("invalid id = $_currentPage");
    }
  }

  int getIndexPage() => _currentPage.value;

  void setPage(int index) {
    _currentPage.value = index;
  }
}
