import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:get/get.dart';

class WashHistoryController extends GetxController {
  Utils utils = Utils();

  // NotificationResponseModel? notificationModel;
  RxString? noData = "".obs;

  /// ---- Get Notification Api ------------>>>
  getNotificationAPI() async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "lat": Constants.latitude,
      "long": Constants.longitude,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getNotifications,
      params: formData,
    );

    //
    // NotificationResponseModel model = NotificationResponseModel.fromJson(data);
    // if (model.code == 200) {
    //   if (page == 1) {
    //     notificationModel = model;
    //     if (notificationModel!.data!.isEmpty) {
    //       noData!.value = "No Notification found";
    //     } else {
    //       noData!.value = "";
    //     }
    //   } else {
    //     for (int i = 0; i < model.data!.length; i++) {
    //       notificationModel!.data!.add(notificationModel!.data![i]);
    //     }
    //   }
    //   update();
    // } else {
    //   utils.showSnackBar(context: Get.context!, message: model.msg!);
    // }
  }
}
