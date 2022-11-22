import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/get_reserve_responce_model.dart';
import 'package:beep_car_wash/model/responce_model/reserve_now_response_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:get/get.dart';

class ReserveController extends GetxController {
  Utils utils = Utils();
  GetReserveResponseModel? getReserveResponseModel;
  ReserveNowResponseModel? reserveNowResponseModel;
  RxString detailString = "".obs;

  /// ---- Get Reserve Details Api ------------>>>
  getReserveDetailsAPI(String id) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "machine_id": id,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getReserveDetails,
      params: formData,
    );

    GetReserveResponseModel model = GetReserveResponseModel.fromJson(data);
    if (model.code == 200) {
      detailString.value = model.tagline!;
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- Reserve Now Api ------------>>>
  reserveNowAPI(String id) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "machine_id": id,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.reserveNow,
      params: formData,
    );

    ReserveNowResponseModel model = ReserveNowResponseModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: Strings.reservationSuccessfully );
      Get.back();
      update();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
