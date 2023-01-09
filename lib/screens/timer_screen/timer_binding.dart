import 'package:beep_car_wash/screens/timer_screen/timer_controller.dart';
import 'package:get/get.dart';

class TimerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TimerController>(TimerController());
  }
}
