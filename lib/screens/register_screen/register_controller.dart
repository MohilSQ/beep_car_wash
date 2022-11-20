import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/common_token_responce_model.dart';
import 'package:beep_car_wash/model/responce_model/user_data_model.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Utils utils = Utils();
  GetStorageData getStorage = GetStorageData();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool? firstNameError = false.obs;
  RxBool? lastNameError = false.obs;
  RxBool? emailError = false.obs;

  RxBool? termsAndPrivacy = true.obs;

  UserDataModel userDataModel = UserDataModel();

  RxBool? isLoading = false.obs;

  /// ---- User Registartion Api ------------>>>
  userRegistartionAPI() async {
    isLoading!.value = true;
    var formData = ({
      "token": Get.arguments[2],
      "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
      "email": emailController.text.trim(),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.userRegistration,
      params: formData,
    );

    CommonTokenResponseModel model = CommonTokenResponseModel.fromJson(data);
    isLoading!.value = false;
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      storeUserData(model.token);
      Get.to(() => const DrawerScreen(), binding: DrawerBindings());
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  storeUserData(String? token) {
    userDataModel.firstName = firstNameController.text.trim();
    userDataModel.lastName = lastNameController.text.trim();
    userDataModel.email = emailController.text.trim();
    userDataModel.cCode = Get.arguments[0];
    userDataModel.phoneNumber = Get.arguments[1];
    userDataModel.token = token;
    update();
    getStorage.saveObject(getStorage.loginData, userDataModel);
  }

  bool validation() {
    if (utils.isValidationEmpty(firstNameController.text)) {
      firstNameError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter your first name");
    } else if (utils.isValidationEmpty(lastNameController.text)) {
      firstNameError!.value = false;
      lastNameError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter your last name");
    } else if (utils.isValidationEmpty(emailController.text)) {
      lastNameError!.value = false;
      emailError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter your email");
    } else if (!utils.emailValidator(emailController.text)) {
      lastNameError!.value = false;
      emailError!.value = true;
      utils.showSnackBar(context: Get.context!, message: "Plese enter your valid email");
    } else {
      emailError!.value = false;
      utils.hideKeyboard(Get.context!);
      return true;
    }
    return false;
  }
}
