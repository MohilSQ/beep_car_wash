import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// <<< To get text View --------- >>>
class MyTextView extends Text {
  final TextAlign? textAlignNew;
  final int? maxLinesNew;
  final TextStyle? textStyleNew;
  final TextOverflow? overflowText;
  final bool? isMaxLineWrap;
  final TextDirection? textAlignment;

  MyTextView(
    String? s, {
    Key? key,
    this.textAlignment,
    this.textAlignNew = TextAlign.start,
    this.maxLinesNew = 1,
    this.overflowText = TextOverflow.ellipsis,
    this.isMaxLineWrap = false,
    this.textStyleNew,
  })  : assert(s != null && maxLinesNew != null),
        super(
          s!,
          key: key,
          textAlign: textAlignNew,
          maxLines: isMaxLineWrap! ? null : maxLinesNew,
          overflow: isMaxLineWrap ? null : overflowText,
          style: textStyleNew,
          textDirection: textAlignment,
        );
}

/// <<< To get text view style --------- >>>
class MyTextStyle extends TextStyle {
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textSize;
  final String? textFamily;
  final TextDecoration? textDecorations;
  final Paint? textBackground;
  final double? textLetterSpacing;
  final double? textHeight;
  final FontStyle? textStyle;

  const MyTextStyle({
    this.textHeight,
    this.textColor = Colors.black,
    this.textWeight = FontWeight.normal,
    this.textSize = 14,
    this.textFamily = Constants.fontFamily,
    this.textDecorations = TextDecoration.none,
    this.textBackground,
    this.textLetterSpacing = 0.0,
    this.textStyle = FontStyle.normal,
  })  : assert(textColor != null && textWeight != null),
        super(
          color: textColor,
          fontWeight: textWeight,
          fontSize: textSize,
          fontFamily: textFamily,
          decoration: textDecorations,
          background: textBackground,
          letterSpacing: textLetterSpacing,
          height: textHeight,
          fontStyle: textStyle,
        );
}

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
