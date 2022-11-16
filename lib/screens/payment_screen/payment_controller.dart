import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:get/get.dart';

import '../../api_repository/api_function.dart';
import '../../commons/constants.dart';
import '../../commons/utils.dart';
import '../../model/responce_model/get_payment_detail_model.dart';

class PaymentController extends GetxController {
  Utils utils = Utils();
  GetPaymentDetailsModel getPaymentDetailsModel = GetPaymentDetailsModel();
  RxString? noData = "".obs;
  RxInt? primaryIndex = 0.obs;

  String getCardImage(String cardName) {
    switch (cardName) {
      case "MIR":
        return ImagePath.mnpLogo;
      case "UnionPay":
        return ImagePath.unionPayLogo;
      case "Visa":
        return ImagePath.visaLogo;
      case "Mastercard":
        return ImagePath.mastercardLogo;
      case "JCB":
        return ImagePath.jcBLogo;
      case "Discover":
        return ImagePath.discoverLogo;
      case "Maestro":
        return ImagePath.maestroLogo;
      case "Amex":
        return ImagePath.americanExpressLogo;
      case "DinersClub":
        return ImagePath.discoverLogo;
      case "PayPal":
        return ImagePath.paypalLogo;
      case "Apple Pay":
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
      if (getPaymentDetailsModel.data!.isEmpty) {
        noData!.value = "No payment detail found";
      } else {
        noData!.value = "";
        for (int i = 0; i < getPaymentDetailsModel.data!.length; i++) {
          if (getPaymentDetailsModel.data![i].primaryCard == "1") {
            primaryIndex!.value = i;
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
      getPaymentDetailsModel.data![primaryIndex!.value].primaryCard = "0";
      primaryIndex!.value = index!;
      getPaymentDetailsModel.data![index].primaryCard = "1";
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
      getPaymentDetailsModel.data!.removeAt(index!);
      for (int i = 0; i < getPaymentDetailsModel.data!.length; i++) {
        if (getPaymentDetailsModel.data![i].primaryCard == "1") {
          primaryIndex!.value = i;
          break;
        }
      }
      update();
    } else {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
    update();
  }
}
