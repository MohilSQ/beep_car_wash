import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/onboarding_screen/onboarding_controller.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_binding.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_screen.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const routeName = "/OnBoardingScreen";
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              Expanded(
                flex: 72,
                child: Image.asset(
                  ImagePath.onBoardingScreenImage,
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyTextView(
                      Strings.washYourCar,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.darkTextColor,
                        textWeight: FontWeight.bold,
                        textSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 1.4.h),
                    MyTextView(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ...",
                      isMaxLineWrap: true,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.lightTextColor,
                        textWeight: FontWeight.w600,
                        textSize: 10.sp,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: Strings.getStarted,
                      onPressed: () {
                        Get.to(() => const SignInScreen(), binding: SignInBindings());
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
    );
  }
}
