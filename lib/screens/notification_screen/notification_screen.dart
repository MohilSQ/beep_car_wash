import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Stack(
      children: [
        ListView.separated(
          itemCount: 2,
          padding: EdgeInsets.symmetric(vertical: 2.h).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height),
          separatorBuilder: (context, index) => SizedBox(height: 0.3.h),
          itemBuilder: (context, index) => Container(
            color: index == 0 ? appColors.lightAppColor : appColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextView(
                      "Super Deal",
                      textStyleNew: MyTextStyle(
                        textColor: index == 1 ? appColors.darkTextColor : appColors.appColorText,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                    MyTextView(
                      "Tue, Sep 13",
                      textStyleNew: MyTextStyle(
                        textColor: appColors.lightTextColor,
                        textWeight: FontWeight.bold,
                        textSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                MyTextView(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore",
                  isMaxLineWrap: true,
                  textStyleNew: MyTextStyle(
                    textColor: index == 1 ? appColors.lightTextColor : appColors.darkTextColor,
                    textWeight: FontWeight.w600,
                    textSize: 11.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Image.asset(
                  ImagePath.dummyImage1,
                ),
                SizedBox(height: 1.4.h),
              ],
            ),
          ),
        ),
        const CustomAppBar(
          title: Strings.notification,
        ),
      ],
    );
  }
}
