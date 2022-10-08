import 'package:beep_car_wash/screens/splash_screen/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SplashController>(SplashController());
  }
}
