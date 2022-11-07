import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_binding.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_bindings.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_screen.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_binding.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_screen.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_binding.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen(), binding: SplashBindings()),
    GetPage(name: OnBoardingScreen.routeName, page: () => const OnBoardingScreen(), binding: OnBoardingBindings()),
    GetPage(name: SignInScreen.routeName, page: () => const SignInScreen(), binding: SignInBindings()),
    GetPage(name: SettingsScreen.routeName, page: () => const SettingsScreen(), binding: SettingsBindings()),
  ];
}
