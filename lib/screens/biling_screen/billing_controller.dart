import 'dart:ui' as ui;

import 'package:beep_car_wash/commons/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../../commons/image_path.dart';
import '../common_controller.dart';

class BillingController extends GetxController {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  TextEditingController code = TextEditingController();
  Utils utils = Utils();

  setMarker(double lat, double long) async {
    Uint8List markerIcon = await getBytesFromAssets(ImagePath.marker, 160);
    final Marker marker = Marker(
      markerId: const MarkerId("1"),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    markers[const MarkerId("1")] = marker;
    update();
  }

  /// ---- Verify CoupneCode API ------------>>>
  verifyCouponCodeAPI(String washId) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "wash_id": washId,
      "coupon_code": code.text.trim(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.verifyCouponCode,
      params: formData,
    );

    if (data["code"] == 200) {
      // Get.off(() => BillingScreen(stopMachineResponseModel: stopMachineResponseModel), binding: BillingBinding());
      // Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
      Utils().showSnackBar(context: Get.context!, message: data["msg"]);
      Get.back();
    } else if (data["code"] == 201) {
      Utils().showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  /// ---- Converted Image To Marker Icon ------------>>>
  getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
