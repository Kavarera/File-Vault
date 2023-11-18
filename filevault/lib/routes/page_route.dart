import 'package:filevault/page/home.dart';
import 'package:filevault/page/login.dart';
import 'package:filevault/page/register.dart';
import 'package:filevault/routes/route_name.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ListPageRoute {
  static final pages = [
    GetPage(name: RouteName.login, page: () => const LoginPage()),
    GetPage(name: RouteName.mainPage, page: () => MainPage()),
    GetPage(name: RouteName.register, page: () => const RegisterPage()),
  ];
}
