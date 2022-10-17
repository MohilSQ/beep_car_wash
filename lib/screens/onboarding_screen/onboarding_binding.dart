import 'package:beep_car_wash/screens/onboarding_screen/onboarding_controller.dart';
import 'package:get/get.dart';

class OnBoardingBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<OnBoardingController>(OnBoardingController());
  }
}
