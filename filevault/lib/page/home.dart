import 'package:filevault/controllers/home_controller.dart';
import 'package:filevault/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/hex_color.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    return Scaffold(
      backgroundColor: HexColor("#C8D8E4"),
      body: Row(
        children: <Widget>[
          Obx(() {
            return NavigationRail(
              selectedIndex: _homeController.getIndexPage(),
              elevation: 5,
              leading: Image.asset("assets/images/kavlogo.jpg", scale: 4),
              indicatorColor: Colors.transparent,
              onDestinationSelected: (int index) {
                _homeController.setPage(index);
              },
              labelType: NavigationRailLabelType.selected,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.file_present,
                    size: 30,
                  ),
                  padding: EdgeInsets.only(bottom: 15, top: 10),
                  selectedIcon: Icon(
                    Icons.file_present_sharp,
                    size: 40,
                  ),
                  label: Text('File Vault'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.lock_outlined,
                    size: 30,
                  ),
                  selectedIcon: Icon(
                    Icons.lock,
                    size: 40,
                  ),
                  label: Text('Super Encrypt Text'),
                ),
                // Tambahkan destinasi lainnya sesuai kebutuhan
              ],
            );
          }),
          VerticalDivider(thickness: 1, width: 1),
          // Konten halaman utama
          Expanded(
              child: Obx(
            () => _homeController.getCurrentPage(),
          )),
        ],
      ),
    );
  }
}
