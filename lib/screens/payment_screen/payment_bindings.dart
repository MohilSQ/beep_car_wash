import 'package:beep_car_wash/screens/payment_screen/payment_controller.dart';
import 'package:get/get.dart';

class PaymentBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<PaymentController>(PaymentController());
  }
}
