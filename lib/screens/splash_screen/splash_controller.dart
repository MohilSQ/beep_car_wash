import 'package:beep_car_wash/screens/onboarding_screen/onboarding_binding.dart';
import 'package:beep_car_wash/screens/onboarding_screen/onboarding_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    Future.delayed(const Duration(seconds: 3), () => pageNavigation());
    super.onReady();
  }

  void pageNavigation() {
    Get.offAll(const OnBoardingScreen(), binding: OnBoardingBindings());
  }
}
