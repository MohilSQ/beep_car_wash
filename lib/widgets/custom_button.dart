import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double horizontalPadding;
  final bool? showGradient;
  final AlignmentGeometry? gradientAlignmentBegin;
  final AlignmentGeometry? gradientAlignmentEnd;
  final List<Color>? gradientColors;
  final double? borderRadius;
  final BorderSide borderSide;
  final double? elevation;
  final Color? overlayColor;
  final Color? shadowColor;
  final bool? disableButton;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final String? image;
  final double? imageSize;
  final String? text;
  final Color? textColor;
  final TextStyle? style;

  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.backgroundColor,
    this.horizontalPadding = 0,
    this.showGradient = false,
    this.gradientAlignmentBegin,
    this.gradientAlignmentEnd,
    this.gradientColors,
    this.borderRadius,
    this.borderSide = BorderSide.none,
    this.elevation,
    this.overlayColor,
    this.shadowColor,
    this.disableButton,
    this.onLongPress,
    required this.onPressed,
    this.child,
    this.icon,
    this.iconColor,
    this.image,
    this.imageSize,
    this.text,
    this.textColor,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return SizedBox(
      height: height ?? 6.h,
      width: width ?? double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: showGradient == true
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: gradientAlignmentBegin ?? Alignment.topLeft,
                    end: gradientAlignmentEnd ?? Alignment.bottomRight,
                    colors: gradientColors ??
                        [
                          appColors.redColor,
                          appColors.yellowColor,
                        ],
                  ),
                  borderRadius: BorderRadius.circular(borderRadius ?? 1.2.h),
                ),
                child: elevatedButton(context),
              )
            : elevatedButton(context),
      ),
    );
  }

  Widget elevatedButton(BuildContext context) {
    AppColors appColors = AppColors();
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: borderSide,
            borderRadius: BorderRadius.circular(borderRadius ?? 1.2.h),
          ),
        ),
        elevation: MaterialStateProperty.all(elevation),
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.pressed) ? overlayColor ?? appColors.blackColor.withOpacity(0.14) : null;
        }),
        shadowColor: MaterialStateProperty.all(showGradient == true ? appColors.transparentColor : shadowColor),
        backgroundColor: MaterialStateProperty.all(
          showGradient == true ? appColors.transparentColor : backgroundColor ?? (disableButton != true ? appColors.buttonColor : Theme.of(context).disabledColor),
        ),
      ),
      onPressed: disableButton != true ? onPressed : null,
      onLongPress: onLongPress,
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: iconColor ?? appColors.whiteColor,
                  size: 24,
                )
              else
                const SizedBox(),
              if (image != null && image != "")
                Row(
                  children: [
                    Image.asset(
                      image!,
                      height: imageSize ?? 22,
                    ),
                    SizedBox(width: 0.9.h)
                  ],
                )
              else
                const SizedBox(),
              if (text != null && text != "")
                MyTextView(
                  text!,
                  textAlignNew: TextAlign.center,
                  textStyleNew: style ??
                      MyTextStyle(
                        textColor: textColor ?? appColors.whiteColor,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                )
              else
                const SizedBox(),
            ],
          ),
    );
  }
}
