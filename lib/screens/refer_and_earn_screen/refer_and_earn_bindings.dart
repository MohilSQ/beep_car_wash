import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_controller.dart';
import 'package:get/get.dart';

class ReferAndEarnBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ReferAndEarnController>(ReferAndEarnController());
  }
}
