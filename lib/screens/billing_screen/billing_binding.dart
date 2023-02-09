import 'package:beep_car_wash/screens/billing_screen/billing_controller.dart';
import 'package:get/get.dart';

class BillingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BillingController>(BillingController());
  }
}
