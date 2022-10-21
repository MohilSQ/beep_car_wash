import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_controller.dart';
import 'package:get/get.dart';

class TermsOfConditionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<TermsOfConditionController>(TermsOfConditionController());
  }
}
