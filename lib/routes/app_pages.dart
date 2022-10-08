import 'package:beep_car_wash/screens/onboarding_screen/onboarding_binding.dart';
import 'package:beep_car_wash/screens/onboarding_screen/onboarding_screen.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_binding.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen(), binding: SplashBindings()),
    GetPage(name: SplashScreen.routeName, page: () => const OnBoardingScreen(), binding: OnBoardingBindings()),
  ];
}
