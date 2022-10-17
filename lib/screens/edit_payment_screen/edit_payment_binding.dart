import 'package:beep_car_wash/screens/edit_payment_screen/edit_payment_controller.dart';
import 'package:get/get.dart';

class EditPaymentBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<EditPaymentController>(EditPaymentController());
  }
}
