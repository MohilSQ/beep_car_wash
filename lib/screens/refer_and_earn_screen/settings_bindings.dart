import 'package:beep_car_wash/screens/refer_and_earn_screen/settings_controller.dart';
import 'package:get/get.dart';

class ReferAndEarnBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ReferAndEarnController>(ReferAndEarnController());
  }
}
