import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<OnBoardingController>(OnBoardingController());
  }
}
