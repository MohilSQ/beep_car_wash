import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxBool? firstNameError = false.obs;
  RxBool? lastNameError = false.obs;
  RxBool? emailError = false.obs;
}
