import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/response_model/get_feedback_remark_response_model.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../common_controller.dart';

class FeedbackController extends GetxController {
  Utils utils = Utils();
  TextEditingController comment = TextEditingController();

  GetFeedbackRemarkModel getFeedbackRemarkModel = GetFeedbackRemarkModel();

  RxList<String> list = <String>[].obs;
  RxList<String> options = <String>[].obs;
  RxList<String> optionsID = <String>[].obs;
  RxString rating = "".obs;

  /// ---- FeedbackRemarks Api ------------>>>
  getFeedbackRemarksAPI(String rate) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "rating": rate,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getFeedbackRemarks,
      params: formData,
    );

    GetFeedbackRemarkModel model = GetFeedbackRemarkModel.fromJson(data);
    if (model.code == 200) {
      getFeedbackRemarkModel = model;
      options.value = [];
      optionsID.value = [];
      list.value = [];
      for (int i = 0; i < getFeedbackRemarkModel.data!.length; i++) {
        options.add(getFeedbackRemarkModel.data?[i].remark ?? "");
        optionsID.add(getFeedbackRemarkModel.data?[i].id ?? "");
      }
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Submit Feedback Api ------------>>>
  submitFeedbacksAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "rating": rating.value,
      "wash_id": Get.arguments,
      "remark_id": list,
      "message": comment.text.trim(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.submitFeedback,
      params: formData,
    );

    GetFeedbackRemarkModel model = GetFeedbackRemarkModel.fromJson(data);
    if (model.code == 200) {
      Get.off(() => const DrawerScreen(), binding: DrawerBindings());
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
