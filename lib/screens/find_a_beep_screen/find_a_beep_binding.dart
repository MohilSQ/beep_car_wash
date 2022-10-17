import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_controller.dart';
import 'package:get/get.dart';

class FindABeepBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<FindABeepController>(FindABeepController());
  }
}
