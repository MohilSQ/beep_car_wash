import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SignInOTPScreen extends GetView<SignInOTPController> {
  const SignInOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      assignId: true,
      init: SignInOTPController(),
      initState: (state) => printAction(Get.arguments.toString()),
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.whiteColor,
                AppColors.whiteColor,
                AppColors.lightAppColor,
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: AppColors.transparentColor,
            body: SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  children: [
                    SizedBox(
                      height: 100.h - MediaQuery.of(context).padding.top,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 3.h),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Align(
                              alignment: Alignment.topLeft,
                              child: BackButtonIcon(),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Image.asset(
                            ImagePath.signInOTP,
                            width: 50.w,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            Strings.enterCodeToVerifyNumber,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.4.h),
                          Text(
                            Get.arguments == null ? "" : Strings.verifyNumber1 + Get.arguments[0] + Get.arguments[1] + Strings.verifyNumber2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 2.4.h),
                          PinCodeTextField(
                            appContext: context,
                            length: 4,
                            textStyle: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.sp,
                            ),
                            pastedTextStyle: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.sp,
                            ),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.scale,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              fieldHeight: 7.5.h,
                              fieldWidth: 18.w,
                              selectedColor: AppColors.grayBorderColor,
                              inactiveColor: AppColors.grayBorderColor,
                              activeColor: AppColors.grayBorderColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 200),
                            enableActiveFill: false,
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                            enablePinAutofill: true,
                            onCompleted: (v) {
                              printOkStatus("Completed");
                              if (controller.validation()) {
                                controller.otpVerificationAPI();
                              }
                            },
                            onChanged: (value) {
                              printAction(value);
                              controller.otpText.value = value;
                              controller.update();
                            },
                            beforeTextPaste: (text) {
                              printAction("Allowing to paste $text");
                              return true;
                            },
                          ),
                          SizedBox(height: 2.2.h),
                          Text(
                            Strings.doNotReceiveTheOTP,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          GestureDetector(
                            onTap: () => controller.resendOTPAPI(),
                            child: Text(
                              Strings.resendCode,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.appColorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomButton(
                            text: Strings.continueString,
                            onPressed: () {
                              if (controller.validation()) {
                                controller.otpVerificationAPI();
                              }
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
