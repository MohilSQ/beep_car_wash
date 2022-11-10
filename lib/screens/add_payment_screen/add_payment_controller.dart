import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentController extends GetxController {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool cardNumberError = false.obs;
  RxBool cardHolderNameError = false.obs;
  RxBool expirationDateError = false.obs;
  RxBool cvvError = false.obs;
  RxBool primaryPayment = false.obs;

  List<CommonModel> paymentMethodList = [
    CommonModel(image: ImagePath.card, title: Strings.creditCard, isSelected: true.obs),
    CommonModel(image: ImagePath.payPal, title: Strings.payPal, isSelected: false.obs),
    CommonModel(image: ImagePath.applePayment, title: Strings.applePay, isSelected: false.obs),
  ];
}
