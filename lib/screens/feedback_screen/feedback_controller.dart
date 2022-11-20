import 'package:beep_car_wash/commons/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../common_controller.dart';
import 'feedbaak_model.dart';

class FeedbackController extends GetxController {
  TextEditingController comment = TextEditingController();
  GetFeedbackRemarkModel getFeedbackRemarkModel = GetFeedbackRemarkModel();
  Utils utils = Utils();
  RxList<String> list = <String>[].obs;
  RxList<String> options = <String>[].obs;

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
      for (int i = 0; i < getFeedbackRemarkModel.data!.length; i++) {
        options.add(getFeedbackRemarkModel.data?[i].remark ?? "");
      }
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Submit Feedback Api ------------>>>
  submitFeedbacksAPI(String rate) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "rating": rate,
      "wash_id": "",
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
      getFeedbackRemarkModel = model;
      options.value = [];
      for (int i = 0; i < getFeedbackRemarkModel.data!.length; i++) {
        options.add(getFeedbackRemarkModel.data?[i].remark ?? "");
      }
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
