import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final Color? containerColor;
  final bool? isError;
  final double? borderRadius;
  final Widget? child;

  const CustomContainer({
    Key? key,
    this.height,
    this.width,
    this.horizontalPadding,
    this.containerColor,
    this.isError = false,
    this.borderRadius,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Container(
      height: height ?? 6.h,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 1.8.h),
      decoration: BoxDecoration(
        color: containerColor ?? appColors.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 1.6.h),
        border: Border.all(
          color: isError! ? appColors.errorColor : appColors.borderColor,
          width: 1.2,
        ),
      ),
      child: child,
    );
  }
}
