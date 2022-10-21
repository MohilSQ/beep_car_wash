import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/privacy_and_policy_screen/privacy_and_policy_binding.dart';
import 'package:beep_car_wash/screens/privacy_and_policy_screen/privacy_and_policy_screen.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_controller.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_binding.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_screen.dart';
import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_binding.dart';
import 'package:beep_car_wash/screens/terms_of_service_screen/terms_of_service_screen.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);
  static const routeName = "/SettingsScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        initState: (_) {
          if (controller.userDataModel == null) controller.getUserData();
        },
        builder: (_) {
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
                          AppColors.appColorText,
                          AppColors.darkAppColor,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: Strings.setting,
                          shadowVisible: false,
                          appBarColor: AppColors.transparentColor,
                          textColor: AppColors.whiteColor,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: GestureDetector(
                              onTap: () {
                                if (controller.validation()) {
                                  controller.saveSettingsAPI();
                                }
                              },
                              child: MyTextView(
                                Strings.save,
                                textStyleNew: MyTextStyle(
                                  textColor: AppColors.whiteColor,
                                  textWeight: FontWeight.bold,
                                  textSize: 13.6.sp,
                                ),
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
                                color: AppColors.whiteColor,
                              ),
                              child: ClipOval(
                                child: controller.image != null
                                    ? Image.file(
                                        controller.image!,
                                        fit: BoxFit.cover,
                                      )
                                    : !controller.utils.isValidationEmpty(controller.userDataModel!.profilImage)
                                        ? CachedNetworkImage(
                                            imageUrl: Constants.profileImageUrl + controller.userDataModel!.profilImage!,
                                            alignment: Alignment.topCenter,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Image.asset(ImagePath.profileAvtar),
                                            errorWidget: (context, url, error) => Image.asset(ImagePath.profileAvtar),
                                          )
                                        : Image.asset(
                                            ImagePath.profileAvtar,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppColors.transparentColor,
                                  builder: (context) => imageDialog(),
                                );
                              },
                              child: Container(
                                height: 5.h,
                                width: 5.h,
                                padding: EdgeInsets.all(1.2.h),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blackColor.withOpacity(0.15),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Image.asset(ImagePath.camera),
                              ),
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
                              isError: controller.firstNameError.value,
                              hintColor: controller.firstNameError.value ? AppColors.errorColor : AppColors.lightTextColor,
                              textColor: controller.firstNameError.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                              hintColor: controller.lastNameError.value ? AppColors.errorColor : AppColors.lightTextColor,
                              textColor: controller.lastNameError.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                              hintColor: controller.emailError.value ? AppColors.errorColor : AppColors.lightTextColor,
                              textColor: controller.emailError.value ? AppColors.errorColor : AppColors.darkTextColor,
                            );
                          }),
                          SizedBox(height: 1.6.h),
                          Obx(() {
                            return CustomTextField(
                              isTitle: true,
                              enabled: false,
                              title: Strings.phoneNumber,
                              hintText: Strings.phoneNumber,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.number,
                              controller: controller.phoneNumberController,
                              isError: controller.phoneNumberError.value,
                              hintColor: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.lightTextColor,
                              textColor: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.darkTextColor,
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.6.h),
                    Divider(height: 0.8.h),
                    CustomButton(
                      onPressed: () {
                        Get.to(() => const TermsOfServiceScreen(), binding: TermsOfConditionBindings());
                      },
                      elevation: 0,
                      borderRadius: 0,
                      backgroundColor: AppColors.transparentColor,
                      text: Strings.termsOfService,
                      image: ImagePath.termsOfService,
                      widgetSpace: 1.5.h,
                      widgetMainAxis: MainAxisAlignment.start,
                      horizontalPadding: 3.w,
                      style: MyTextStyle(
                        textColor: AppColors.appColorText,
                        textWeight: FontWeight.w600,
                        textSize: 12.sp,
                      ),
                    ),
                    Divider(height: 0.8.h),
                    CustomButton(
                      onPressed: () {
                        Get.to(() => const PrivacyAndPolicyScreen(), binding: PrivacyAndPolicyBindings());
                      },
                      elevation: 0,
                      borderRadius: 0,
                      backgroundColor: AppColors.transparentColor,
                      text: Strings.privacyAndPolicy,
                      image: ImagePath.privacyAndPolicy,
                      widgetSpace: 1.5.h,
                      widgetMainAxis: MainAxisAlignment.start,
                      horizontalPadding: 3.w,
                      style: MyTextStyle(
                        textColor: AppColors.appColorText,
                        textWeight: FontWeight.w600,
                        textSize: 12.sp,
                      ),
                    ),
                    Divider(height: 0.8.h),
                    CustomButton(
                      onPressed: () {},
                      elevation: 0,
                      borderRadius: 0,
                      backgroundColor: AppColors.transparentColor,
                      text: Strings.customerSupport,
                      image: ImagePath.customerSupport,
                      widgetSpace: 1.5.h,
                      widgetMainAxis: MainAxisAlignment.start,
                      horizontalPadding: 3.w,
                      style: MyTextStyle(
                        textColor: AppColors.appColorText,
                        textWeight: FontWeight.w600,
                        textSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () {
                        controller.getStorage.removeData(controller.getStorage.loginData);
                        Get.offAll(() => const SignInScreen(), binding: SignInBindings());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextView(
                            Strings.logOut,
                            textStyleNew: MyTextStyle(
                              textColor: AppColors.lightTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 1.h),
                          Image.asset(ImagePath.logout, height: 2.2.h),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget imageDialog() {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
          ),
          child: Column(
            children: [
              SizedBox(height: 1.8.h),
              Container(
                height: 0.6.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: AppColors.grayBorderColor,
                ),
              ),
              SizedBox(height: 1.4.h),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.back();
                  controller.setProfileImage(ImageSource.gallery);
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: AppColors.transparentColor,
                text: Strings.selectProfilePicture,
                icon: Icons.image,
                iconColor: AppColors.lightTextColor,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: MyTextStyle(
                  textColor: AppColors.lightTextColor,
                  textWeight: FontWeight.w600,
                  textSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.back();
                  controller.setProfileImage(ImageSource.gallery);
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: AppColors.transparentColor,
                text: Strings.takeAProfilePicture,
                icon: Icons.camera_alt,
                iconColor: AppColors.lightTextColor,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: MyTextStyle(
                  textColor: AppColors.lightTextColor,
                  textWeight: FontWeight.w600,
                  textSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              SizedBox(height: MediaQuery.of(Get.context!).padding.bottom + 1.6.h),
            ],
          ),
        ),
      ],
    );
  }
}
