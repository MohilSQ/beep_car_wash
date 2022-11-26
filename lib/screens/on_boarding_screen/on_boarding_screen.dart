import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_controller.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_binding.dart';
import 'package:beep_car_wash/screens/sign_in_screen/sign_in_screen.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const routeName = "/OnBoardingScreen";

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      Strings.washYourCar,
                      style: TextStyle(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
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
