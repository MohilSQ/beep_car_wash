import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_binding.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeController extends GetxController {
  Utils utils = Utils();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      printAction(result!.code!);
      controller.pauseCamera();
      scanToStartAPI();
      update();
    });
  }

  /// ---- Scan To Start API ------------>>>
  scanToStartAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "qr_code": result!.code,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.scanToStart,
      params: formData,
    );

    // ScanToStartResponseModel model = ScanToStartResponseModel.fromJson(data);
    if (data["code"] == 200) {
      if (data["data"]["is_machine_start"] == 0) {
        utils.showSnackBar(context: Get.context!, message: "Machine is reserve for someone, Please wait to his time end.");
        controller!.resumeCamera();
      } else {
        utils.showToast(context: Get.context!, message: "Machine start successfully");
        controller?.stopCamera();
        Get.to(() => TimerScreen(washId: data["data"]["wash_id"], washTimer: data["data"]["wash_timer"]), binding: TimerBinding());
      }
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
      controller!.resumeCamera();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller?.dispose();
  }
}
