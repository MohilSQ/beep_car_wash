import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/wash_history_response_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:get/get.dart';

class WashHistoryController extends GetxController {
  Utils utils = Utils();

  WashHistoryResponseModel? washHistoryResponseModel;
  RxString? noData = "".obs;

  /// ---- Get Wash History Response API ------------>>>
  getWashHistoryResponseAPI() async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getWashHistory,
      params: formData,
    );

    WashHistoryResponseModel model = WashHistoryResponseModel.fromJson(data);
    if (model.code == 200) {
      washHistoryResponseModel = model;
      if (washHistoryResponseModel!.data!.isEmpty) {
        noData!.value = "No Wash History found";
      } else {
        noData!.value = "";
      }
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }
}
