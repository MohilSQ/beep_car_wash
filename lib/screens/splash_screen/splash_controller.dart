import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/onboarding_screen/onboarding_binding.dart';
import 'package:beep_car_wash/screens/onboarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3), () => pageNavigation());
    super.onReady();
  }

  void pageNavigation() {
    if (Get.find<CommonController>().userDataAvilabeOrNot()) {
      Get.find<CommonController>().getUserData();
      Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
    } else {
      Get.offAll(() => const OnBoardingScreen(), binding: OnBoardingBindings());
    }
  }
}
