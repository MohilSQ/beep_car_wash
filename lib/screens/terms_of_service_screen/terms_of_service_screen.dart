import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 3.h),
              children: [
                MyTextView(
                  "Lorem Ipsum",
                  textStyleNew: MyTextStyle(
                    textColor: appColors.darkTextColor,
                    textWeight: FontWeight.bold,
                    textSize: 16.sp,
                  ),
                ),
                SizedBox(height: 1.h),
                MyTextView(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  isMaxLineWrap: true,
                  textStyleNew: MyTextStyle(
                    textColor: appColors.lightTextColor,
                    textWeight: FontWeight.w600,
                    textSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.8.h),
                MyTextView(
                  "Lorem Ipsum",
                  textStyleNew: MyTextStyle(
                    textColor: appColors.darkTextColor,
                    textWeight: FontWeight.bold,
                    textSize: 16.sp,
                  ),
                ),
                SizedBox(height: 1.h),
                MyTextView(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  isMaxLineWrap: true,
                  textStyleNew: MyTextStyle(
                    textColor: appColors.lightTextColor,
                    textWeight: FontWeight.w600,
                    textSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                MyTextView(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  isMaxLineWrap: true,
                  textStyleNew: MyTextStyle(
                    textColor: appColors.lightTextColor,
                    textWeight: FontWeight.w600,
                    textSize: 12.sp,
                  ),
                ),
              ],
            ),
            const CustomAppBar(
              isBack: true,
              title: Strings.termsOfService,
            ),
          ],
        ),
      ),
    );
  }
}
