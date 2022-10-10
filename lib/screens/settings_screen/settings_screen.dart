import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top + 34.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                appColors.appColorText,
                appColors.darkAppColor,
              ],
            ),
          ),
          child: Column(
            children: [
              CustomAppBar(
                title: Strings.setting,
                shadowVisible: false,
                appBarColor: appColors.transparentColor,
                textColor: appColors.whiteColor,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: MyTextView(
                    "Save",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.whiteColor,
                      textWeight: FontWeight.bold,
                      textSize: 13.6.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.8.h),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 20.h,
                    width: 20.h,
                    padding: EdgeInsets.all(0.6.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors.whiteColor,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        ImagePath.dummyImage2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 5.h,
                    width: 5.h,
                    padding: EdgeInsets.all(1.2.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: appColors.blackColor.withOpacity(0.15),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(ImagePath.camera),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
