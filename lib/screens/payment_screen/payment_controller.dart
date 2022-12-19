import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:get/get.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../../commons/strings.dart';
import '../../commons/utils.dart';
import '../../model/responce_model/get_payment_detail_model.dart';

class PaymentController extends GetxController {
  Utils utils = Utils();
  GetPaymentDetailsModel? getPaymentDetailsModel;
  RxString? noData = "".obs;
  RxString? cardLastNumber = "".obs;
  RxString? cardBrand = "".obs;
  RxString? currentBalance = "".obs;

  String getCardImage(String cardName) {
    switch (cardName) {
      case Strings.mir:
        return ImagePath.mnpLogo;
      case Strings.unionPay:
        return ImagePath.unionPayLogo;
      case Strings.visa:
        return ImagePath.visaLogo;
      case Strings.mastercard:
        return ImagePath.mastercardLogo;
      case Strings.jcb:
        return ImagePath.jcBLogo;
      case Strings.discover:
        return ImagePath.discoverLogo;
      case Strings.maestro:
        return ImagePath.maestroLogo;
      case Strings.amex:
        return ImagePath.americanExpressLogo;
      case Strings.dinersClub:
        return ImagePath.discoverLogo;
      case Strings.payPal:
        return ImagePath.paypalLogo;
      case Strings.applePay:
        return ImagePath.appleLogo;
      default:
        return ImagePath.creditCard;
    }
  }

  /// ---- Get Card Details Response API ------------>>>
  getCardDetailsResponseAPI() async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.getPaymentCardList,
      params: formData,
    );

    GetPaymentDetailsModel model = GetPaymentDetailsModel.fromJson(data);
    if (model.code == 200) {
      getPaymentDetailsModel = model;
      currentBalance!.value = getPaymentDetailsModel!.currnetBlance!;
      if (getPaymentDetailsModel!.data!.isEmpty) {
        noData!.value = "No payment detail found";
        cardLastNumber!.value = "****";
        cardBrand!.value = "";
      } else {
        noData!.value = "";
        for (int i = 0; i < getPaymentDetailsModel!.data!.length; i++) {
          if (getPaymentDetailsModel!.data![i].primaryCard == "1") {
            cardLastNumber!.value = getPaymentDetailsModel!.data![i].last4!;
            cardBrand!.value = getPaymentDetailsModel!.data![i].brand!.isEmpty ? getPaymentDetailsModel!.data![i].sourceType! :getPaymentDetailsModel!.data![i].brand! ;
            break;
          }
        }
      }
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  /// ---- SetPrimary Response API ------------>>>
  setPrimaryResponseAPI({int? index, int? id}) async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "source_id": id,
      "primary": 1,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.updatePaymentSource,
      params: formData,
    );

    if (data["code"] == 200) {
      utils.showToast(context: Get.context!, message: data["msg"]);
      for (int i = 0; i < getPaymentDetailsModel!.data!.length; i++) {
        if (getPaymentDetailsModel!.data![i].primaryCard == "1") {
          getPaymentDetailsModel!.data![i].primaryCard = "0";
          break;
        }
      }
      getPaymentDetailsModel!.data![index!].primaryCard = "1";
      cardLastNumber!.value = getPaymentDetailsModel!.data![index].last4!;
      cardBrand!.value = getPaymentDetailsModel!.data![index].brand!.isEmpty ? getPaymentDetailsModel!.data![index].sourceType! :getPaymentDetailsModel!.data![index].brand! ;
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  /// ---- SetPrimary Response API ------------>>>
  deletePaymentResponseAPI({int? index, int? id}) async {
    dynamic formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "source_id": id,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.deletePaymentSource,
      params: formData,
    );

    if (data["code"] == 200) {
      utils.showToast(context: Get.context!, message: data["msg"]);
      if (getPaymentDetailsModel!.data!.length == 1) {
        cardLastNumber!.value = "****";
        getPaymentDetailsModel = null;
        noData!.value = "No payment detail found";
      } else {
        getPaymentDetailsModel!.data!.removeAt(index!);
        for (int i = 0; i < getPaymentDetailsModel!.data!.length; i++) {
          if (getPaymentDetailsModel!.data![i].primaryCard == "1") {
            cardLastNumber!.value = getPaymentDetailsModel!.data![i].last4!;
            break;
          }
        }
      }
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
    update();
  }
}
