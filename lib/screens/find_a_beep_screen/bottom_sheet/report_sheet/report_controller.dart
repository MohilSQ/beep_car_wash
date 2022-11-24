import 'dart:io';

import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:beep_car_wash/model/responce_model/report_respose_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api_repository/api_function.dart';
import '../../../../commons/constants.dart';
import '../../../common_controller.dart';

class ReportController extends GetxController {
  GetReportOptionResponseModel reportOptionModel = GetReportOptionResponseModel();
  Utils utils = Utils();
  RxString noData = "".obs;
  RxString issueId = "".obs;
  RxString machineCode = "".obs;
  RxString image = "".obs;
  final ImagePicker imagePicker = ImagePicker();
  File? image1;

  TextEditingController comment = TextEditingController();

  List<CommonModel> reportList = [
    CommonModel(isSelected: true.obs, title: "Water/Foam pump"),
    CommonModel(isSelected: false.obs, title: "Air Blower"),
    CommonModel(isSelected: false.obs, title: "Vaccum"),
    CommonModel(isSelected: false.obs, title: "Machine won’t turn on"),
    CommonModel(isSelected: false.obs, title: "Other Issue"),
  ];

  setProfileImage(ImageSource source) async {
    XFile? xFile = await imagePicker.pickImage(source: source);
    if (xFile != null) {
      image1 = File(xFile.path.toString());
      image.value = xFile.path.toString();
    }
    update();
  }

  /// ---- Get Report Option Api ------------>>>
  getReportOptionAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getReportOptions,
      params: formData,
    );

    GetReportOptionResponseModel model = GetReportOptionResponseModel.fromJson(data);
    if (model.code == 200) {
      reportOptionModel = model;
      if (model.data!.isEmpty) {
        noData.value = "No option Found";
      } else {
        noData.value = "";
      }
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Submit Report  Api ------------>>>
  submitReportAPI(String machineId) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "machine_id": machineId,
      "machine_code": machineCode.value,
      "issue_id": issueId.value,
      "attachment": image.value,
      "comment": comment.text.trim(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.submitReport,
      params: formData,
    );

    if (data["code"] == 200) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
      Get.back();
      update();
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  @override
  void onInit() {
    getReportOptionAPI();
    super.onInit();
  }
}
