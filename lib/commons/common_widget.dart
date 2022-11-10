import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// ----- Common Check Box -------------------->>>
Widget commonCheckBox({
  BuildContext? context,
  bool? value = true,
}) {
  return Container(
    height: 2.8.h,
    width: 2.8.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(0.7.h),
      border: Border.all(width: 1, color: AppColors.appColor),
      color: value! ? AppColors.transparentColor : AppColors.appColor,
    ),
    child: value
        ? Container()
        : Icon(
            Icons.check_rounded,
            color: AppColors.whiteColor,
            size: 1.8.h,
          ),
  );
}
