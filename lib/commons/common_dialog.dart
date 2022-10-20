import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void alertActionDialog({
  required BuildContext context,
  String? massage,
  String? rightBtnName,
  String? leftBtnName,
  GestureTapCallback? onRightClick,
}) async {
  Utils utils = Utils();

  utils.hideKeyboard(context);

  showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
          elevation: 8,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(width: 1.5, color: AppColors.appColorText),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextView(
                  Strings.appName,
                  textStyleNew: MyTextStyle(
                    textSize: 16.sp,
                    textWeight: FontWeight.bold,
                    textColor: AppColors.appColorText,
                  ),
                ),
                SizedBox(height: 1.h),
                MyTextView(
                  massage ?? "",
                  isMaxLineWrap: true,
                  textAlignNew: TextAlign.center,
                  textStyleNew: MyTextStyle(
                    textSize: 12.sp,
                    textWeight: FontWeight.w500,
                    textColor: AppColors.darkTextColor,
                  ),
                ),
                SizedBox(height: 2.6.h),
                Row(
                  children: [
                    SizedBox(width: 1.w),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Get.back(),
                        text: leftBtnName ?? Strings.no,
                        height: 4.8.h,
                        textColor: AppColors.appColorText,
                        backgroundColor: AppColors.transparentColor,
                        borderSide: BorderSide(color: AppColors.appColor),
                        elevation: 0,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomButton(
                        onPressed: onRightClick!,
                        text: leftBtnName ?? Strings.yes,
                        height: 4.8.h,
                      ),
                    ),
                    SizedBox(width: 1.w),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

void messageDialog({
  required BuildContext context,
  String? massage,
  String? btnName,
  GestureTapCallback? onBtnClick,
}) async {
  Utils utils = Utils();
  utils.hideKeyboard(context);
  showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
          elevation: 8,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(2.h),
              border: Border.all(width: 1.5, color: AppColors.appColorText),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyTextView(
                  Strings.appName,
                  textStyleNew: MyTextStyle(
                    textSize: 16.sp,
                    textWeight: FontWeight.bold,
                    textColor: AppColors.appColorText,
                  ),
                ),
                SizedBox(height: 1.h),
                MyTextView(
                  massage ?? "",
                  isMaxLineWrap: true,
                  textAlignNew: TextAlign.center,
                  textStyleNew: MyTextStyle(
                    textSize: 12.sp,
                    textWeight: FontWeight.w500,
                    textColor: AppColors.darkTextColor,
                  ),
                ),
                SizedBox(height: 2.6.h),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: CustomButton(
                        onPressed: onBtnClick ?? () => Get.back(),
                        text: btnName ?? Strings.ok,
                        height: 4.8.h,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
