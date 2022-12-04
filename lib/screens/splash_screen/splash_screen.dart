import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      assignId: true,
      init: SplashController(),
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.appColor,
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    ImagePath.appLogo,
                    width: 45.w,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 1.6.h),
                    child: const SpinKitCircle(
                      color: Colors.white,
                      size: 50.0,
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
