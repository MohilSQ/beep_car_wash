import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/otp_verification_model.dart';
import 'package:beep_car_wash/model/responce_model/common_responce_model.dart';
import 'package:beep_car_wash/model/responce_model/user_data_model.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/register_screen/register_binding.dart';
import 'package:beep_car_wash/screens/register_screen/register_screen.dart';
import 'package:get/get.dart';

class SignInOTPController extends GetxController {
  Utils utils = Utils();
  GetStorageData getStorage = GetStorageData();

  RxString otpText = "".obs;
  UserDataModel userDataModel = UserDataModel();

  /// ---- OTP Verification Api ------------>>>
  otpVerificationAPI() async {
    var formData = ({
      "otp": otpText.value.trim(),
      "token": Get.arguments[2],
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.otpVerification,
      params: formData,
    );

    OTPVerificationModel model = OTPVerificationModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      if (model.isNewUser == 0) {
        userDataModel.firstName = model.userDetail!.name!.split(" ").first;
        userDataModel.lastName = model.userDetail!.name!.split(" ").last;
        userDataModel.email = model.userDetail!.email;
        userDataModel.cconde = Get.arguments[0];
        userDataModel.phoneNumber = Get.arguments[1];
        userDataModel.token = model.token;
        update();
        getStorage.saveObject(getStorage.loginData, userDataModel);
        Get.to(() => const DrawerScreen(), binding: DrawerBindings());
      } else if (model.isNewUser == 1) {
        Get.to(() => const RegisterScreen(), binding: RegisterBindings(), arguments: [Get.arguments[0], Get.arguments[1], model.token]);
      }
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  /// ---- Resend OTP Api ------------>>>
  resendOTPAPI() async {
    var formData = ({
      "token": Get.arguments[2],
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.resendOTP,
      params: formData,
    );

    CommonResponceModel model = CommonResponceModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  bool validation() {
    if (otpText.isEmpty) {
      utils.showSnackBar(context: Get.context!, message: "Plese enter OTP");
    } else if (otpText.value.length < 4) {
      utils.showSnackBar(context: Get.context!, message: "Plese enter full OTP");
    } else {
      return true;
    }
    return false;
  }
}
