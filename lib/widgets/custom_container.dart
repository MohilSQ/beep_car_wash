import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? horizontalPadding;
  final EdgeInsetsGeometry? padding;
  final Color? containerColor;
  final bool? errorView;
  final double? borderRadius;
  final bool? circleView;
  final bool? boxShadowVisible;
  final bool? borderVisible;
  final bool? isHeight;
  final Widget? child;

  const CustomContainer({
    Key? key,
    this.height,
    this.width,
    this.horizontalPadding,
    this.padding,
    this.containerColor,
    this.errorView = false,
    this.borderRadius,
    this.circleView = false,
    this.boxShadowVisible = false,
    this.borderVisible = false,
    this.isHeight = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isHeight! ? height ?? 6.h : null,
      width: width,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.symmetric(horizontal: horizontalPadding ?? (circleView! ? 0 : 1.8.h)),
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.whiteColor,
        borderRadius: circleView! ? null : BorderRadius.circular(borderRadius ?? 1.6.h),
        border: borderVisible!
            ? Border.all(
                color: errorView! ? AppColors.errorColor : AppColors.borderColor,
                width: 1.2,
              )
            : null,
        shape: circleView! ? BoxShape.circle : BoxShape.rectangle,
        boxShadow: boxShadowVisible!
            ? [
                BoxShadow(
                  color: AppColors.lightGreyColor,
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
