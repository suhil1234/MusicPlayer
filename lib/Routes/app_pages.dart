import 'package:get/get.dart';
import '../bindings/NavigationBindings.dart';
import '../view/NavigationPage.dart';
import '../view/SongsPage.dart';


import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.Navigation,
      page: () => NavigationPage(),
      binding: NavigationBinding(),
    ),
  ];
}