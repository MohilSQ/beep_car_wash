import 'package:beep_car_wash/screens/drawer_screen/drawer_controller.dart';
import 'package:get/get.dart';

class DrawerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<DrawerScreenController>(DrawerScreenController());
  }
}
