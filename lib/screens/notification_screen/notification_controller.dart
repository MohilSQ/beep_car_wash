import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/response_model/notification_response_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  Utils utils = Utils();

  NotificationResponseModel? notificationModel;
  RxString? noData = "".obs;

  ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;

  pagination() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (notificationModel!.data!.length < notificationModel!.totalRecords!) {
          page++;
          isLoading.value = true;
          printAction("page ----------->>> $page");
          getNotificationAPI(page: page.value);
        }
      }
    });
  }

  /// ---- Get Notification Api ------------>>>
  getNotificationAPI({int page = 1}) async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "lat": Constants.latitude,
      "long": Constants.longitude,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: "${Constants.getNotifications}?page=$page",
      params: formData,
      isLoading: page == 1,
    );

    NotificationResponseModel model = NotificationResponseModel.fromJson(data);
    isLoading.value = false;
    if (model.code == 200) {
      if (page == 1) {
        notificationModel = model;
        if (notificationModel!.data!.isEmpty) {
          noData!.value = "No Notification found";
        } else {
          noData!.value = "";
        }
      } else {
        for (int i = 0; i < model.data!.length; i++) {
          notificationModel!.data!.add(notificationModel!.data![i]);
        }
      }
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }
}
