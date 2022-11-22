import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/register_screen/register_controller.dart';
import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_binding.dart';
import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_screen.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          Text(
                            Strings.createYourAccount,
                            style: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 3.8.h),
                          Obx(() {
                            return CustomTextField(
                              hintText: Strings.firstName,
                              inputType: TextInputType.name,
                              controller: controller.firstNameController,
                              isError: controller.firstNameError!.value,
                              hintColor: controller.firstNameError!.value ? AppColors.errorColor : AppColors.lightTextColor,
                              color: controller.firstNameError!.value ? AppColors.errorColor : AppColors.darkTextColor,
                            );
                          }),
                          SizedBox(height: 2.h),
                          Obx(() {
                            return CustomTextField(
                              hintText: Strings.lastName,
                              inputType: TextInputType.name,
                              controller: controller.lastNameController,
                              isError: controller.lastNameError!.value,
                              hintColor: controller.lastNameError!.value ? AppColors.errorColor : AppColors.lightTextColor,
                              color: controller.lastNameError!.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                              hintColor: controller.emailError!.value ? AppColors.errorColor : AppColors.lightTextColor,
                              color: controller.emailError!.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.blackColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: Strings.termsOfService,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => const TermsOfServiceScreen(), binding: TermsOfConditionBindings());
                                          },
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: AppColors.appColorText,
                                        ),
                                      ),
                                      TextSpan(
                                        text: Strings.and,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: AppColors.appColorText,
                                        ),
                                      ),
                                      TextSpan(
                                        text: Strings.privacyAndPolicy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => const RegisterScreen());
                                          },
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                          color: AppColors.appColorText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Obx(() => CustomButton(
                                text: Strings.register,
                                disableButton: controller.termsAndPrivacy!.value,
                                isLoading: controller.isLoading!.value,
                                onPressed: () {
                                  if (controller.validation()) {
                                    if (!controller.isLoading!.value) {
                                      controller.userRegistrationAPI();
                                    }
                                  }
                                },
                              )),
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
