import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/notify_me_sheet/notify_me_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotifyMeSheet extends GetView<NotifyMeController> {
  const NotifyMeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotifyMeController());
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Strings.nearestBeep,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Image.asset(
                ImagePath.undrawLocationTracking,
                width: 50.w,
              ),
              SizedBox(height: 3.h),
              Text(
                Strings.notifyMeTitle,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              SizedBox(height: 0.4.h),
              Text(
                Strings.notifyMeDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightTextColor,
                ),
              ),
              SizedBox(height: 3.4.h),
              CustomButton(
                onPressed: () {
                  controller.notifyMeAPI();
                },
                elevation: 0,
                height: 5.h,
                width: 46.w,
                text: Strings.notifyMe,
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 2.4.h),
            ],
          ),
        ),
      ],
    );
  }
}
