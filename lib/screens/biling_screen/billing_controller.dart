import 'dart:ui' as ui;

import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/stop_machine_response_model.dart';
import 'package:beep_car_wash/screens/feedback_screen/feedback_binding.dart';
import 'package:beep_car_wash/screens/feedback_screen/feedback_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../../commons/image_path.dart';
import '../common_controller.dart';

class BillingController extends GetxController {
  Utils utils = Utils();
  TextEditingController code = TextEditingController();
  RxString washId = "".obs;
  StopMachineResponseModel? stopMachineResponseModel;
  RxList<Marker> markers = <Marker>[].obs;
  RxString trxAmount = "".obs;
  RxString trxId = "".obs;


  /// ---- Converted Image To Marker Icon ------------>>>
  getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  /// ---- Set Marker ------------>>>
  setMarker(double lat, double long) async {
    Uint8List markerIcon = await getBytesFromAssets(ImagePath.marker, 160);

    final Marker marker = Marker(
      markerId: const MarkerId("1"),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    markers.add(marker);
    update();
  }

  /// ---- Verify CouponCode API ------------>>>
  verifyCouponCodeAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "wash_id": washId.value,
      "coupon_code": code.text.trim(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.verifyCouponCode,
      params: formData,
    );

    if (data["code"] == 200) {
      utils.showToast(context: Get.context!, message: data["msg"]);
      Get.back();
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Save Wash Bill By Credit Card API ------------>>>
  saveWashBillByCreditCardAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "payment_id": washId.value,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.saveCardPayment,
      params: formData,
    );

    if (data["code"] == 200) {
      Get.to(() => const FeedbackScreen(), binding: FeedbackBinding(), arguments: washId.value);
      utils.showToast(context: Get.context!, message: data["msg"]);
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Save Wash Bill By UPI API ------------>>>
  saveWashBillByUPIAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "payment_id": washId.value,
        "payment_method":  stopMachineResponseModel!.data!.paymentSourceType!,
        "trx_id": trxId,
        "trx_amount": trxAmount,
        "trx_datetime":DateTime.now().toString(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.saveOtherMethodPayment,
      params: formData,
    );

    if (data["code"] == 200) {
      Get.to(() => const FeedbackScreen(), binding: FeedbackBinding(), arguments: washId.value);
      utils.showToast(context: Get.context!, message: data["msg"]);
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
