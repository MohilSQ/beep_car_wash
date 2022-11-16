import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool? shadowVisible;
  final bool? isBack;
  final bool? isButton;
  final Color? appBarColor;
  final Color? color;
  final Widget? suffixIcon;
  final double? height;
  final Widget? bottonChild;
  const CustomAppBar({
    Key? key,
    this.title,
    this.shadowVisible = true,
    this.isBack = false,
    this.isButton = true,
    this.appBarColor,
    this.color,
    this.suffixIcon,
    this.height,
    this.bottonChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).padding.top + AppBar().preferredSize.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: MediaQuery.of(context).padding.top).copyWith(bottom: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: appBarColor ?? AppColors.whiteColor,
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
      child: Column(
        children: [
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isButton!
                  ? GestureDetector(
                      onTap: () {
                        if (isBack!) {
                          Get.back();
                        } else {
                          Constants.scaffoldKey.currentState!.openDrawer();
                        }
                      },
                      child: Container(
                        width: 4.6.h,
                        height: 4.6.h,
                        padding: EdgeInsets.symmetric(horizontal: 1.2.h),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(isBack! ? ImagePath.back : ImagePath.drawer, color: color),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(width: 2.6.w),
              Text(
                title!,
                style: TextStyle(
                  color: color ?? AppColors.darkTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.6.sp,
                ),
              ),
              const Spacer(),
              suffixIcon ?? const SizedBox()
            ],
          ),
          const Spacer(),
          bottonChild ?? const SizedBox(),
        ],
      ),
    );
  }
}
