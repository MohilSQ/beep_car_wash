import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPaymentController extends GetxController {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool cardNumberError = false.obs;
  RxBool cardHolderNameError = false.obs;
  RxBool expirationDateError = false.obs;
  RxBool cvvError = false.obs;
  RxBool primaryPayment = false.obs;
}
