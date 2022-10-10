import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SignInOTPScreen extends GetView<SignInOTPController> {
  const SignInOTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return GetBuilder(
      assignId: true,
      init: SignInOTPController(),
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                appColors.whiteColor,
                appColors.whiteColor,
                appColors.lightAppColor,
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: appColors.transparentColor,
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
                          MyTextView(
                            Strings.enterCodeToVerifyNumber,
                            textAlignNew: TextAlign.center,
                            textStyleNew: MyTextStyle(
                              textColor: appColors.darkTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.4.h),
                          MyTextView(
                            "${Strings.verifyNumber1}+01 2345443243${Strings.verifyNumber2}",
                            isMaxLineWrap: true,
                            textAlignNew: TextAlign.center,
                            textStyleNew: MyTextStyle(
                              textColor: appColors.lightTextColor,
                              textWeight: FontWeight.w600,
                              textSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 2.4.h),
                          PinCodeTextField(
                            appContext: context,
                            length: 4,
                            textStyle: MyTextStyle(
                              textColor: appColors.darkTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 23.sp,
                            ),
                            pastedTextStyle: MyTextStyle(
                              textColor: appColors.darkTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 23.sp,
                            ),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.scale,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              fieldHeight: 7.5.h,
                              fieldWidth: 18.w,
                              selectedColor: appColors.grayBorderColor,
                              inactiveColor: appColors.grayBorderColor,
                              activeColor: appColors.grayBorderColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: const Duration(milliseconds: 200),
                            enableActiveFill: false,
                            // controller: textEditingController,
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                            enablePinAutofill: true,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              debugPrint(value);
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                          ),
                          SizedBox(height: 2.2.h),
                          MyTextView(
                            Strings.doNotReceiveTheOTP,
                            textAlignNew: TextAlign.center,
                            textStyleNew: MyTextStyle(
                              textColor: appColors.lightTextColor,
                              textWeight: FontWeight.w600,
                              textSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 0.8.h),
                          MyTextView(
                            Strings.resendCode,
                            textAlignNew: TextAlign.center,
                            textStyleNew: MyTextStyle(
                              textColor: appColors.appColorText,
                              textWeight: FontWeight.bold,
                              textSize: 11.sp,
                            ),
                          ),
                          const Spacer(),
                          CustomButton(
                            text: Strings.continueString,
                            onPressed: () {
                              Get.to(() => const DrawerScreen(), binding: DrawerBindings());
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 2.2.h),
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
