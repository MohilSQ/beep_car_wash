import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool fistNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool emailError = false.obs;
  RxBool phoneNumberError = false.obs;
  RxBool passwordError = false.obs;
}
