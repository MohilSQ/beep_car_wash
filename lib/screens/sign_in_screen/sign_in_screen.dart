import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = "/SignInScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      assignId: true,
      init: SignInController(),
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
                          SizedBox(height: 5.h),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              ImagePath.appNameImage,
                              width: 30.w,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            Strings.enterYourPhoneNumber,
                            style: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.4.h),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ...",
                            style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 4.5.h),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  controller.showCountryCodePicker();
                                },
                                child: CustomContainer(
                                  borderVisible: true,
                                  horizontalPadding: 1.2.h,
                                  child: controller.selectedCountry == null
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                controller.selectedCountry!.flag,
                                                package: countryCodePackageName,
                                                width: 3.4.h,
                                                height: 3.4.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(width: 1.2.h),
                                            Image.asset(
                                              ImagePath.downArrow,
                                              width: 1.6.h,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              SizedBox(width: 1.h),
                              Expanded(
                                child: Obx(() {
                                  return CustomTextField(
                                    hintText: Strings.inputPhoneNumber,
                                    textInputAction: TextInputAction.done,
                                    inputType: TextInputType.phone,
                                    controller: controller.phoneNumberController,
                                    isError: controller.phoneNumberError!.value,
                                    hintColor: controller.phoneNumberError!.value ? AppColors.errorColor : AppColors.lightTextColor,
                                    color: controller.phoneNumberError!.value ? AppColors.errorColor : AppColors.darkTextColor,
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Obx(() {
                            return CustomButton(
                              text: Strings.continueString,
                              isLoading: controller.isLoading!.value,
                              onPressed: () {
                                if (controller.validation()) {
                                  if (!controller.isLoading!.value) {
                                    controller.phoneVerificationAPI();
                                  }
                                }
                              },
                            );
                          }),
                          SizedBox(height: 3.5.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              Strings.orSignInWith,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.lightTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.5.h),
                          CustomButton(
                            text: Strings.google,
                            image: ImagePath.google,
                            imageSize: 3.2.h,
                            color: AppColors.darkTextColor,
                            backgroundColor: AppColors.transparentColor,
                            borderSide: BorderSide(color: AppColors.appColor),
                            elevation: 0,
                            onPressed: () {},
                          ),
                          SizedBox(height: 2.2.h),
                          CustomButton(
                            text: Strings.facebook,
                            image: ImagePath.facebook,
                            imageSize: 3.h,
                            color: AppColors.darkTextColor,
                            backgroundColor: AppColors.transparentColor,
                            borderSide: BorderSide(color: AppColors.appColor),
                            elevation: 0,
                            onPressed: () {},
                          ),
                          SizedBox(height: 2.2.h),
                          CustomButton(
                            text: Strings.appleID,
                            image: ImagePath.apple,
                            imageSize: 3.2.h,
                            color: AppColors.darkTextColor,
                            backgroundColor: AppColors.transparentColor,
                            borderSide: BorderSide(color: AppColors.appColor),
                            elevation: 0,
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
          ),
        );
      },
    );
  }
}
