import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_controller.dart';
import 'package:get/get.dart';

class SignInOTPBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SignInOTPController>(SignInOTPController());
  }
}
