import 'package:beep_car_wash/api_repository/api_class.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class APIFunction {
  ConnectivityResult? connectivityResult;
  final Connectivity connectivity = Connectivity();

  getConnectivityResult() async {
    connectivityResult = await connectivity.checkConnectivity();
  }

  /// ------ To Call Post Api -------------------->>>
  Future<dynamic> postApiCall({
    required String apiName,
    required BuildContext context,
    dynamic params,
    bool isLoading = true,
    bool isFormData = false,
  }) async {
    printAction("params -------->>> ${isFormData ? params!.fields : params}");
    try {
      getConnectivityResult();
      printOkStatus(connectivityResult.toString());
      if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
        var response = await HttpUtil(isLoading, context).post(
          apiName,
          data: params,
        );
        return response;
      } else {
        Utils().showSnackBar(context: Get.context!, message: Strings.noInternatAvilable);
      }
    } on PlatformException catch (e) {
      printError(e.toString());
      Utils().showSnackBar(context: Get.context!, message: Strings.noInternatAvilable);
    }
  }

  /// ------ To Call Get Api -------------------->>>
  Future<dynamic> getApiCall({
    required String apiName,
    required BuildContext context,
    dynamic params,
    bool isLoading = true,
  }) async {
    printAction("params -------->>> $params");
    try {
      getConnectivityResult();
      printOkStatus(connectivityResult.toString());
      if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
        var response = await HttpUtil(isLoading, context).get(
          apiName,
          queryParameters: params,
        );
        return response;
      } else {
        Utils().showSnackBar(context: Get.context!, message: Strings.noInternatAvilable);
      }
    } on PlatformException catch (e) {
      printError(e.toString());
      Utils().showSnackBar(context: Get.context!, message: Strings.noInternatAvilable);
    }
  }
}
