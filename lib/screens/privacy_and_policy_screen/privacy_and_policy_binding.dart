import 'package:beep_car_wash/screens/privacy_and_policy_screen/privacy_and_policy_controller.dart';
import 'package:get/get.dart';

class PrivacyAndPolicyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<PrivacyAndPolicyController>(PrivacyAndPolicyController());
  }
}
