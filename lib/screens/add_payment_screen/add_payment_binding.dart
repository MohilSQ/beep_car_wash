import 'package:beep_car_wash/screens/add_payment_screen/add_payment_controller.dart';
import 'package:get/get.dart';

class AddPaymentBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AddPaymentController>(AddPaymentController());
  }
}
