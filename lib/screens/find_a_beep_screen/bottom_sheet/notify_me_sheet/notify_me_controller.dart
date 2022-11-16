import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/map_service.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/common_responce_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class NotifyMeController extends GetxController {
  Utils utils = Utils();

  /// ---- Notify Me Api ------------>>>
  notifyMeAPI() async {
    FormData formData = FormData.fromMap({
      "token": Get.find<CommonController>().userDataModel.token,
      "name": ("${Get.find<CommonController>().userDataModel.firstName!} ${Get.find<CommonController>().userDataModel.lastName!}"),
      "email": Get.find<CommonController>().userDataModel.email,
      "phone": Get.find<CommonController>().userDataModel.phoneNumber,
      "city": MapService.currentCity,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.notifyMe,
      params: formData,
      isFormData: true,
    );

    CommonResponseModel model = CommonResponseModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      Get.back();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  @override
  void onInit() {
    super.onInit();
    MapService.getCityFromLatLng(lat: Constants.latitude, log: Constants.longitude);
  }
}
