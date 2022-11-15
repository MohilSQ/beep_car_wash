import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../../commons/utils.dart';
import '../common_controller.dart';

class AddPaymentController extends GetxController {
  Utils utils = Utils();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  RxBool cardNumberError = false.obs;
  RxBool cardHolderNameError = false.obs;
  RxBool expirationDateError = false.obs;
  RxBool cvvError = false.obs;
  RxBool primaryPayment = false.obs;
  RxInt cardNumber = 0.obs;
  RxInt cvvNumber = 0.obs;

  RxString expireMonth = "".obs;
  RxString expireyear = "".obs;

  List<CommonModel> paymentMethodList = [
    CommonModel(image: ImagePath.card, title: Strings.creditCard, isSelected: true.obs),
    CommonModel(image: ImagePath.payPal, title: Strings.payPal, isSelected: false.obs),
    CommonModel(image: ImagePath.applePayment, title: Strings.applePay, isSelected: false.obs),
  ];

  /// ---- Validation ------------>>>

  bool isValid() {
    if (cardNumberController.text.trim().isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Strings.vInputCardNumber);
      return false;
    } else if (cardNumber.value != 19) {
      utils.showSnackBar(context: Get.context!, message: Strings.vInputCardNumberValid);
      return false;
    } else if (cardHolderNameController.text.trim().isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Strings.vCardHolderName);
      return false;
    } else if (expirationDateController.text.trim().isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Strings.vExpirationDate);
      return false;
    } else if (expireMonth.value == "" || expireyear.value == "") {
      utils.showSnackBar(context: Get.context!, message: Strings.vExpirationDateValid);
      return false;
    } else if (cvvController.text.trim().isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Strings.vCvv);
      return false;
    } else if (cvvNumber.value != 3) {
      utils.showSnackBar(context: Get.context!, message: Strings.vCvvValid);
      return false;
    }
    return true;
  }

  /// ---- Save Card Details Response API ------------>>>
  saveCardDetailsResponseAPI(int i) async {
    dynamic formData = FormData({});

    if (paymentMethodList[i].title == Strings.creditCard) {
      formData = ({
        "token": Get.find<CommonController>().userDataModel.token,
        "payment_method": 1,
        "number": cardNumberController.text.trim(),
        "exp_month": expireMonth.value.trim(),
        "exp_year": expireyear.value.trim(),
        "cvc": cvvController.text.trim(),
        "primary": primaryPayment.value ? 1 : 0,
      });
    } else if (paymentMethodList[i].title == Strings.payPal) {
      formData = ({
        "token": Get.find<CommonController>().userDataModel.token,
        "payment_method": 2,
        "primary": primaryPayment.value ? 1 : 0,
      });
    } else if (paymentMethodList[i].title == Strings.applePay) {
      formData = ({
        "token": Get.find<CommonController>().userDataModel.token,
        "payment_method": 3,
        "primary": primaryPayment.value ? 1 : 0,
      });
    }

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.savePaymentCardList,
      params: formData,
    );

    utils.showSnackBar(context: Get.context!, message: data["msg"]);
    Get.back();

    update();
  }
}
