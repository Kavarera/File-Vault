import 'package:filevault/encryption/hashing.dart';
import 'package:filevault/models/users.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isRegistered = false.obs;

  Future<void> register(String username, String password) async {
    try {
      final user = User(
          id: 0, username: username, password: getHash(username, password));
      await user.insertUser();
      isRegistered.value = true;
    } catch (e) {
      isRegistered.value = false;
      print("error when register user : $e");
    }
  }
}
