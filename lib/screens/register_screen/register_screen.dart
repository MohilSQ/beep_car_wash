import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
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
                            Strings.createYourAccount,
                            textStyleNew: MyTextStyle(
                              textColor: appColors.darkTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 3.8.h),
                          Obx(() {
                            return CustomTextField(
                              hintText: Strings.firstName,
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
                              hintText: Strings.lastName,
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
                              hintText: Strings.email,
                              textInputAction: TextInputAction.done,
                              inputType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              isError: controller.emailError!.value,
                              hintColor: controller.emailError!.value ? appColors.errorColor : appColors.lightTextColor,
                              textColor: controller.emailError!.value ? appColors.errorColor : appColors.darkTextColor,
                            );
                          }),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    controller.termsAndPrivacy!.value = !controller.termsAndPrivacy!.value;
                                  },
                                  child: commonCheckBox(
                                    context: context,
                                    value: controller.termsAndPrivacy!.value,
                                  ),
                                );
                              }),
                              SizedBox(width: 1.2.h),
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: Strings.byCreatingAnAccountYouAgreeToBeep,
                                    style: MyTextStyle(
                                      textWeight: FontWeight.w600,
                                      textSize: 12.sp,
                                      textColor: appColors.blackColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: Strings.termsOfServiceAndPrivacyPolicy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Get.to(() => const RegisterScreen(), binding: RegisterBindings());
                                          },
                                        style: MyTextStyle(
                                          textWeight: FontWeight.bold,
                                          textSize: 12.sp,
                                          textColor: appColors.appColorText,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          CustomButton(
                            text: Strings.register,
                            onPressed: () {
                              Get.back();
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
