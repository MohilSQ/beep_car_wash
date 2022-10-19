import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxBool fistNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool emailError = false.obs;
  RxBool phoneNumberError = false.obs;

  @override
  void onReady() {
    super.onReady();
    printAction("text");
    firstNameController.text = Get.find<CommonController>().userDataModel.firstName!;
    lastNameController.text = Get.find<CommonController>().userDataModel.lastName!;
    emailController.text = Get.find<CommonController>().userDataModel.email!;
    phoneNumberController.text = Get.find<CommonController>().userDataModel.cconde! + Get.find<CommonController>().userDataModel.phoneNumber!;
  }
}
