import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../commons/image_path.dart';
import '../../commons/strings.dart';
import '../custom_camera_screen/custom_camera_binding.dart';
import '../custom_camera_screen/custom_camera_screen.dart';

class TimerScreen extends GetView<TimerController> {
  final String? washId;
  final String? washTimer;
  const TimerScreen({this.washId, this.washTimer, Key? key}) : super(key: key);

  static const routeName = "/TimerScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const CustomAppBar(
                  title: "Timer",
                  isButton: false,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Your remains time is ${controller.min.value}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 72.w,
                  height: 72.w,
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7FBF4),
                  ),
                  child: Container(
                    width: 76.w,
                    height: 76.w,
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD9F3EA),
                    ),
                    child: CircularCountDownTimer(
                      duration: 36000,
                      initialDuration: 0,
                      controller: controller.countDownController.value,
                      width: 60.w,
                      height: 60.w,
                      ringColor: AppColors.whiteColor,
                      fillColor: AppColors.appColorText,
                      strokeWidth: 0.6.h,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.appColorText,
                        fontWeight: FontWeight.bold,
                      ),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        printAction('Countdown Started');
                      },
                      onComplete: () {
                        printOkStatus('Countdown Ended');
                      },
                      onChange: (String timeStamp) {
                        printAction('Countdown Changed $timeStamp');
                      },
                      timeFormatterFunction: (defaultFormatterFunction, duration) {
                        if (duration.inSeconds == 0) {
                          return "00:00";
                        } else {
                          controller.min.value = duration.inMinutes;

                          return Function.apply(defaultFormatterFunction, [duration]);
                        }
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: CustomButton(
                    onPressed: () {
                      openBottomApplyCodeSheet(context);

                      // controller.stopMachineAPI(washId!);
                    },
                    text: "Stop",
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
              ],
            ),
          ),
        );
      },
    );
  }

  openBottomApplyCodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparentColor,
      barrierColor: AppColors.transparentColor,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.endWash,
                        style: TextStyle(
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      const Spacer(),
                      const CloseButton(),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    Strings.important,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImagePath.termsOfService,
                        color: AppColors.yellowColor,
                        height: 2.4.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          Strings.importantPoint1,
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImagePath.termsOfService,
                        color: AppColors.yellowColor,
                        height: 2.4.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          Strings.importantPoint2,
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                      color: const Color(0xFFFFE7E2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImagePath.termsOfService,
                          color: AppColors.redColor,
                          height: 2.4.h,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            Strings.importantPointWarring,
                            softWrap: true,
                            style: TextStyle(
                              color: AppColors.redColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomButton(
                    onPressed: () {
                      Get.to(() => const CustomCameraScreen(), binding: CustomCameraBinding());
                      // Get.to(() => const BillingScreen(), binding: BillingBinding());
                    },
                    // backgroundColor: AppColors.appColor,
                    text: "Okay",
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        Get.back(result: value);
      }
    });
  }
}
