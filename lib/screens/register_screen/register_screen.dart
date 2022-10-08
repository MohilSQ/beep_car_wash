import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/register_screen/register_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return GetBuilder(
      assignId: true,
      init: RegisterController(),
      builder: (logic) {
        return Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const BackButtonIcon(),
                        ),
                        SizedBox(height: 2.h),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            ImagePath.appNameImage,
                            width: 30.w,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        MyTextView(
                          "Create your Account",
                          textStyleNew: MyTextStyle(
                            textColor: appColors.darkTextColor,
                            textWeight: FontWeight.bold,
                            textSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 3.8.h),
                        Obx(() {
                          return CustomTextField(
                            hintText: "First Name",
                            inputType: TextInputType.name,
                            controller: controller.firstNameController,
                            isError: controller.firstNameError!.value,
                            hintColor: controller.firstNameError!.value ? appColors.errorColor : appColors.lightTextColor,
                            textColor: controller.firstNameError!.value ? appColors.errorColor : appColors.darkTextColor,
                          );
                        }),
                        SizedBox(height: 2.h),
                        Obx(() {
                          return CustomTextField(
                            hintText: "Last Name",
                            inputType: TextInputType.name,
                            controller: controller.lastNameController,
                            isError: controller.lastNameError!.value,
                            hintColor: controller.lastNameError!.value ? appColors.errorColor : appColors.lightTextColor,
                            textColor: controller.lastNameError!.value ? appColors.errorColor : appColors.darkTextColor,
                          );
                        }),
                        SizedBox(height: 2.h),
                        Obx(() {
                          return CustomTextField(
                            hintText: "Email",
                            textInputAction: TextInputAction.done,
                            inputType: TextInputType.emailAddress,
                            controller: controller.emailController,
                            isError: controller.emailError!.value,
                            hintColor: controller.emailError!.value ? appColors.errorColor : appColors.lightTextColor,
                            textColor: controller.emailError!.value ? appColors.errorColor : appColors.darkTextColor,
                          );
                        }),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "By creating an account you agree to beep ",
                            style: MyTextStyle(
                              textWeight: FontWeight.w600,
                              textSize: 12.sp,
                              textColor: appColors.lightTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Terms of Service and Privacy Policy",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Get.to(() => const RegisterScreen(), binding: RegisterBindings());
                                  },
                                style: MyTextStyle(
                                  textWeight: FontWeight.bold,
                                  textSize: 12.sp,
                                  textColor: appColors.appColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.h),
                        CustomButton(
                          text: "Register",
                          onPressed: () {},
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
