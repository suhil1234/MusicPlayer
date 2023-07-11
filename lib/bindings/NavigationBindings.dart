import 'package:get/get.dart';
import '../controller/NavigationController.dart';


class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    
  }
}