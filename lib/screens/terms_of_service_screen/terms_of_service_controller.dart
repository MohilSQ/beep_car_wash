import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/model/responce_model/term_of_condition_model.dart';
import 'package:get/get.dart';

class TermsOfConditionController extends GetxController {
  HtmlViewModel? htmlViewModel;

  /// ---- Terms Of Condition Api ------------>>>
  termsOfConditionAPI() async {
    final data = await APIFunction().getApiCall(
      context: Get.context!,
      apiName: Constants.termsAndConditions,
    );

    HtmlViewModel model = HtmlViewModel.fromJson(data);
    if (model.code == 200) {
      htmlViewModel = model;
      update();
    }
  }

  @override
  void onInit() {
    termsOfConditionAPI();
    super.onInit();
  }
}
