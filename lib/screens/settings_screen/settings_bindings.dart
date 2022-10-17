import 'package:beep_car_wash/screens/settings_screen/settings_controller.dart';
import 'package:get/get.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController());
  }
}
