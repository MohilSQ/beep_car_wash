import 'package:beep_car_wash/screens/register_screen/register_controller.dart';
import 'package:get/get.dart';

class RegisterBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
    // TODO: implement dependencies
  }
}
