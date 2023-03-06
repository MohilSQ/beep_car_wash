import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_dialog.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TimerScreen extends GetView<TimerController> {
  final String? isFrom;
  final String? washId;
  final int? totalTime;
  final int? remainTime;
  final int? isFareFix;
  final int? consumedTime;

  const TimerScreen({
    Key? key,
    this.isFrom,
    this.washId,
    this.totalTime,
    this.remainTime,
    this.isFareFix,
    this.consumedTime,
  }) : super(key: key);

  static const routeName = "/TimerScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimerController>(
      assignId: true,
      dispose: (state) {},
      initState: (state) {
        controller.start.value = isFareFix == 0 ? consumedTime! : totalTime!;
        controller.startTimer(isFareFix: isFareFix);
      },
      builder: (logic) {
        return WillPopScope(
          onWillPop: () {
            messageDialog(
              massage: "Please first stop machine and complete the payment.",
              btnName: "Ok",
            );
            return Future(() => false);
          },
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const CustomAppBar(
                    title: Strings.timer,
                    isButton: false,
                  ),
                  SizedBox(height: 4.h),
                  Obx(() {
                    return Text(
                      isFareFix == 0 ? "You are using machine from ${Duration(seconds: controller.start.value).toString().split(".").first.replaceAll("0:", "")} min" : "${Strings.yourRemainsTimeIs}${Duration(seconds: controller.start.value).toString().split(".").first.replaceAll("0:", "")}${Strings.min}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    );
                  }),
                  SizedBox(height: 5.h),
                  isFareFix == 0
                      ? Container(
                          width: 72.w,
                          height: 72.w,
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE7FBF4),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD9F3EA),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.appColorText,
                                  width: 0.6.h,
                                ),
                              ),
                              child: Obx(() {
                                return Text(
                                  Duration(seconds: controller.start.value).toString().split(".").first.replaceAll("0:", ""),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.appColorText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : Container(
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
                              duration: totalTime!,
                              initialDuration: isFrom == "SplashScreen" ? (totalTime! - remainTime!) : 0,
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
                                controller.stopMachineAPI(washId!);
                              },
                              onChange: (String timeStamp) {
                                printAction('Countdown Changed $timeStamp');
                                controller.update();
                              },
                              timeFormatterFunction: (defaultFormatterFunction, duration) {
                                if (duration.inSeconds == 0) {
                                  return "00:00";
                                } else {
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
                        controller.stopMachineAPI(washId!);
                      },
                      text: Strings.stop,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
