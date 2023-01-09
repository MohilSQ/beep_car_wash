import 'package:beep_car_wash/screens/scan_qr_code_screen/scan_qr_code_controller.dart';
import 'package:get/get.dart';

class ScanQRCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ScanQrCodeController>(ScanQrCodeController());
  }
}
