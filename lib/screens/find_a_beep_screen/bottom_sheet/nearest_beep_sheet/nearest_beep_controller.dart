import 'dart:async';
import 'dart:io';

import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class NearestBeepController extends GetxController {
  RxInt isExpand = 0.obs;
  Rx<CountDownController> countDownController = CountDownController().obs;

  List<CommonModel> actionList = [
    CommonModel(index: 0, image: ImagePath.navigation, title: Strings.navigation),
    CommonModel(index: 1, image: ImagePath.qrScan, title: Strings.scanToStart),
    CommonModel(index: 2, image: ImagePath.reserve, title: Strings.reserve),
    CommonModel(index: 3, image: ImagePath.report, title: Strings.report),
  ];

  List<CommonModel> machineData = [
    CommonModel(index: 0, image: ImagePath.droplet, title: "Spotless Water"),
    CommonModel(index: 1, image: ImagePath.bubble, title: "Triple Foam"),
    CommonModel(index: 2, image: ImagePath.wind, title: "Air Dryer"),
    CommonModel(index: 3, image: ImagePath.vaccum, title: "Vacuum Cleaner"),
  ];

  List showCaseKeyList = [
    Constants.firstShowCase,
    Constants.secondShowCase,
    Constants.thirdShowCase,
    Constants.fourthShowCase,
  ];

  List showCaseDesList = [
    "Click here to get direction\nto Wash Machine",
    "Click here to scan\nthe wash machine",
    "Click here to order\na car wash",
    "Click here to report\nan issue or problem",
  ];

  showCaseF(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context).startShowCase([
        Constants.firstShowCase,
        Constants.secondShowCase,
        Constants.thirdShowCase,
        Constants.fourthShowCase,
      ]),
    );
    Get.find<CommonController>().getStorageData.saveString(Get.find<CommonController>().getStorageData.isFirst, "0");
  }

  RxInt start = 0.obs;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      start.value++;
    });
    update();
  }

  Uri createCoordinatesUri(String latitude, String longitude, [String? label]) {
    Uri uri;

    if (Platform.isAndroid) {
      var query = '$latitude,$longitude';
      if (label != null) query += '($label)';
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude', 'q': label ?? '$latitude, $longitude'};
      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': '$latitude,$longitude'});
    }
    return uri;
  }
}
