import 'package:beep_car_wash/screens/sign_in_screen/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(SignInController());
  }
}
