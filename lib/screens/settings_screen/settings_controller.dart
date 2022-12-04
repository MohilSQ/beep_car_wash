import 'dart:io';

import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/common_response_model.dart';
import 'package:beep_car_wash/model/responce_model/update_profile_response_image.dart';
import 'package:beep_car_wash/model/responce_model/user_data_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  Utils utils = Utils();
  GetStorageData getStorage = GetStorageData();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool emailError = false.obs;
  RxBool phoneNumberError = false.obs;

  UserDataModel? userDataModel;

  final ImagePicker imagePicker = ImagePicker();
  File? image;

  getUserData() {
    userDataModel = Get.find<CommonController>().userDataModel;
    firstNameController.text = userDataModel!.firstName!;
    lastNameController.text = userDataModel!.lastName!;
    emailController.text = userDataModel!.email!;
    phoneNumberController.text = "${userDataModel!.cCode!} ${userDataModel!.phoneNumber!}";
  }

  setUserData() {
    userDataModel!.firstName = firstNameController.text;
    userDataModel!.lastName = lastNameController.text;
    userDataModel!.email = emailController.text;
    userDataModel!.cCode = phoneNumberController.text.split(" ").first;
    userDataModel!.phoneNumber = phoneNumberController.text.split(" ").last;
    getStorage.saveObject(getStorage.loginData, userDataModel);
    Get.find<CommonController>().getUserData();
  }

  setProfileImage(ImageSource source) async {
    XFile? xFile = await imagePicker.pickImage(source: source);
    if (xFile != null) {
      image = File(xFile.path.toString());
    }
    update();
  }

  /// ---- Save Settings Api ------------>>>
  saveSettingsAPI() async {
    var formData = ({
      "token": userDataModel!.token,
      "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
      "email": emailController.text.trim(),
      "phone": phoneNumberController.text.trim().replaceAll(" ", ""),
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.saveSettings,
      params: formData,
    );

    CommonResponseModel model = CommonResponseModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      setUserData();
      if (image != null) {
        saveImageAPI();
      }
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  /// ---- Save Settings Api ------------>>>
  saveImageAPI() async {
    FormData formData = FormData.fromMap({
      "token": userDataModel!.token,
    });

    formData.files.addAll([
      MapEntry("avatar", MultipartFile.fromFileSync(image!.path, filename: image!.path.split("/").last)),
    ]);

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.uploadProfileImage,
      params: formData,
      isLoading: false,
      isFormData: true,
    );

    UploadProfileResponseImage model = UploadProfileResponseImage.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      userDataModel!.profileImage = model.avatar;
      getStorage.saveObject(getStorage.loginData, userDataModel);
      Get.find<CommonController>().getUserData();
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  bool validation() {
    if (utils.isValidationEmpty(firstNameController.text)) {
      firstNameError.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vFirstName);
    } else if (utils.isValidationEmpty(lastNameController.text)) {
      firstNameError.value = false;
      lastNameError.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vLastName);
    } else if (utils.isValidationEmpty(emailController.text)) {
      lastNameError.value = false;
      emailError.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vEmail);
    } else if (!utils.emailValidator(emailController.text)) {
      lastNameError.value = false;
      emailError.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vValidEmail);
    } else {
      firstNameError.value = false;
      lastNameError.value = false;
      emailError.value = false;
      utils.hideKeyboard(Get.context!);
      return true;
    }
    return false;
  }
}
