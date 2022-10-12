import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/privacy_and_policy_screen/privacy_and_policy_screen.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_controller.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_binding.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_screen.dart';
import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_screen.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/SettingsScreen";

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + 34.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    appColors.appColorText,
                    appColors.darkAppColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    title: Strings.setting,
                    shadowVisible: false,
                    appBarColor: appColors.transparentColor,
                    textColor: appColors.whiteColor,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: MyTextView(
                        Strings.save,
                        textStyleNew: MyTextStyle(
                          textColor: appColors.whiteColor,
                          textWeight: FontWeight.bold,
                          textSize: 13.6.sp,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.h,
                        padding: EdgeInsets.all(0.6.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColors.whiteColor,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImagePath.dummyImage2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 5.h,
                        width: 5.h,
                        padding: EdgeInsets.all(1.2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: appColors.blackColor.withOpacity(0.15),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(ImagePath.camera),
                      ),
                    ],
                  ),
                  const Spacer(flex: 8),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    Obx(() {
                      return CustomTextField(
                        isTitle: true,
                        title: Strings.firstName,
                        hintText: Strings.firstName,
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        controller: controller.firstNameController,
                        isError: controller.fistNameError.value,
                        hintColor: controller.fistNameError.value ? appColors.errorColor : appColors.lightTextColor,
                        textColor: controller.fistNameError.value ? appColors.errorColor : appColors.darkTextColor,
                      );
                    }),
                    SizedBox(height: 1.6.h),
                    Obx(() {
                      return CustomTextField(
                        isTitle: true,
                        title: Strings.lastName,
                        hintText: Strings.lastName,
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        controller: controller.lastNameController,
                        isError: controller.lastNameError.value,
                        hintColor: controller.lastNameError.value ? appColors.errorColor : appColors.lightTextColor,
                        textColor: controller.lastNameError.value ? appColors.errorColor : appColors.darkTextColor,
                      );
                    }),
                    SizedBox(height: 1.6.h),
                    Obx(() {
                      return CustomTextField(
                        isTitle: true,
                        title: Strings.email,
                        hintText: Strings.email,
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        isError: controller.emailError.value,
                        hintColor: controller.emailError.value ? appColors.errorColor : appColors.lightTextColor,
                        textColor: controller.emailError.value ? appColors.errorColor : appColors.darkTextColor,
                      );
                    }),
                    SizedBox(height: 1.6.h),
                    Obx(() {
                      return CustomTextField(
                        isTitle: true,
                        title: Strings.phoneNumber,
                        hintText: Strings.phoneNumber,
                        textInputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        controller: controller.phoneNumberController,
                        isError: controller.phoneNumberError.value,
                        hintColor: controller.phoneNumberError.value ? appColors.errorColor : appColors.lightTextColor,
                        textColor: controller.phoneNumberError.value ? appColors.errorColor : appColors.darkTextColor,
                      );
                    }),
                    SizedBox(height: 1.6.h),
                    Obx(() {
                      return CustomTextField(
                        isTitle: true,
                        title: Strings.password,
                        hintText: Strings.password,
                        textInputAction: TextInputAction.done,
                        inputType: TextInputType.multiline,
                        controller: controller.passwordController,
                        obscureText: true,
                        isError: controller.passwordError.value,
                        hintColor: controller.passwordError.value ? appColors.errorColor : appColors.lightTextColor,
                        textColor: controller.passwordError.value ? appColors.errorColor : appColors.darkTextColor,
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 2.6.h),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.to(() => const TermsOfServiceScreen());
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: appColors.transparentColor,
                text: Strings.termsOfService,
                image: ImagePath.termsOfService,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: MyTextStyle(
                  textColor: appColors.appColorText,
                  textWeight: FontWeight.w600,
                  textSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.to(() => const PrivacyAndPolicyScreen());
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: appColors.transparentColor,
                text: Strings.privacyAndPolicy,
                image: ImagePath.privacyAndPolicy,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: MyTextStyle(
                  textColor: appColors.appColorText,
                  textWeight: FontWeight.w600,
                  textSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {},
                elevation: 0,
                borderRadius: 0,
                backgroundColor: appColors.transparentColor,
                text: Strings.customerSupport,
                image: ImagePath.customerSupport,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: MyTextStyle(
                  textColor: appColors.appColorText,
                  textWeight: FontWeight.w600,
                  textSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => const SignInScreen(), binding: SignInBindings());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTextView(
                      Strings.logOut,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.lightTextColor,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 1.h),
                    Image.asset(ImagePath.logout, height: 2.2.h),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
            ],
          ),
        ),
      ],
    );
  }
}
