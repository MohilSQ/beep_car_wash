import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/model/response_model/html_view_model.dart';
import 'package:get/get.dart';

class HowItWorkController extends GetxController {
  HtmlViewModel? htmlViewModel;

  /// ---- How It Work API ------------>>>
  howItWorkAPI() async {
    final data = await APIFunction().getApiCall(
      context: Get.context!,
      apiName: Constants.howItWorks,
    );

    HtmlViewModel model = HtmlViewModel.fromJson(data);
    if (model.code == 200) {
      htmlViewModel = model;
      update();
    }
  }
}
