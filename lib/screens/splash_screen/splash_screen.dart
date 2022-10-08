import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return GetBuilder(
      assignId: true,
      init: SplashController(),
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: appColors.appColor,
              alignment: Alignment.center,
              child: Image.asset(
                ImagePath.appLogo,
                width: 45.w,
              ),
            ),
          ),
        );
      },
    );
  }
}
