import 'package:beep_car_wash/api_repository/api_class.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIFunction {
  Future<dynamic> apiCall({
    required String apiName,
    required BuildContext context,
    FormData? params,
    String? token = "",
    bool isLoading = true,
  }) async {
    printAction("params -------->>> ${params!.fields}");
    var response = await HttpUtil(token!, isLoading, context).post(
      apiName,
      data: params,
    );
    return response;
  }
}
