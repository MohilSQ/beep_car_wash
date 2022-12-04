import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/common_response_model.dart';
import 'package:beep_car_wash/model/responce_model/otp_verification_response_model.dart';
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

  RxBool? isLoading = false.obs;

  /// ---- OTP Verification Api ------------>>>
  otpVerificationAPI() async {
    isLoading!.value = true;
    var formData = ({
      "otp": otpText.value.trim(),
      "token": Get.arguments[2],
      "device_id": getStorage.readString(getStorage.deviceId),
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.otpVerification,
      params: formData,
      isLoading: false,
    );

    OTPVerificationResponseModel model = OTPVerificationResponseModel.fromJson(data);
    isLoading!.value = false;
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      if (model.isNewUser == 0) {
        userDataModel.firstName = model.userDetail!.name!.split(" ").first;
        userDataModel.lastName = model.userDetail!.name!.split(" ").last;
        userDataModel.email = model.userDetail!.email;
        userDataModel.cCode = Get.arguments[0];
        userDataModel.phoneNumber = Get.arguments[1];
        userDataModel.token = model.token;
        userDataModel.profileImage = model.userDetail!.avatar!;
        update();
        getStorage.saveObject(getStorage.loginData, userDataModel);
        Get.off(() => const DrawerScreen(), binding: DrawerBindings());
      } else if (model.isNewUser == 1) {
        Get.off(() => const RegisterScreen(), binding: RegisterBindings(), arguments: [Get.arguments[0], Get.arguments[1], model.token]);
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

    CommonResponseModel model = CommonResponseModel.fromJson(data);
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  bool validation() {
    if (otpText.isEmpty) {
      utils.showSnackBar(context: Get.context!, message: Strings.vOTP);
    } else if (otpText.value.length < 4) {
      utils.showSnackBar(context: Get.context!, message: Strings.vFullOTP);
    } else {
      return true;
    }
    return false;
  }
}
