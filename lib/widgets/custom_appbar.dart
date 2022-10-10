import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? shadowVisible;
  final Color? appBarColor;
  final Color? textColor;
  final Widget? suffixIcon;
  const CustomAppBar({
    Key? key,
    this.title,
    this.shadowVisible = true,
    this.appBarColor,
    this.textColor,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Container(
      height: MediaQuery.of(context).padding.top + AppBar().preferredSize.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: MediaQuery.of(context).padding.top).copyWith(bottom: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appBarColor ?? appColors.whiteColor,
        boxShadow: shadowVisible!
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 14,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Constants.scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              width: 4.6.h,
              height: 4.6.h,
              padding: EdgeInsets.symmetric(horizontal: 1.2.h),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(ImagePath.drawer, color: textColor),
            ),
          ),
          SizedBox(width: 2.6.w),
          MyTextView(
            title!,
            textStyleNew: MyTextStyle(
              textColor: textColor ?? appColors.darkTextColor,
              textWeight: FontWeight.bold,
              textSize: 14.6.sp,
            ),
          ),
          const Spacer(),
          suffixIcon ?? const SizedBox()
        ],
      ),
    );
  }
}
