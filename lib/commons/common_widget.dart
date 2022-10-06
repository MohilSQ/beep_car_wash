import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

/// <<< To get TextFiled --------- >>>
/// NOTE: Do not remove and edit ---------->>>
Widget commonTextField({
  BuildContext? context,
  TextEditingController? controller,
  bool? obscureText = false,
  String? hintText,
  Color? hintColor,
  bool? enabled = true,
  TextAlign? textAlign = TextAlign.start,
  TextInputType? inputType = TextInputType.text,
  List<TextInputFormatter>? inputFormat,
  TextInputAction? textInputAction = TextInputAction.next,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  FocusNode? focusNode,
  bool? isMaxLines = false,
  int? maxLength,
  int? minLines,
  int? maxLines = 1,
}) {
  AppColors appColors = AppColors();
  return TextField(
    controller: controller,
    cursorColor: appColors.blackColor,
    cursorWidth: ResponsiveFlutter.of(context).scale(1.2),
    keyboardType: inputType,
    enabled: enabled,
    obscureText: obscureText!,
    textInputAction: textInputAction,
    onSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    textAlign: textAlign!,
    autocorrect: false,
    autofocus: false,
    focusNode: focusNode,
    maxLines: isMaxLines! ? null : maxLines,
    maxLength: maxLength,
    minLines: minLines,
    inputFormatters: inputFormat,
    style: MyTextStyle(
      textWeight: FontWeight.w400,
      textSize: ResponsiveFlutter.of(context).fontSize(1.9),
      textColor: appColors.orangeColor,
    ),
    decoration: InputDecoration(
      isDense: false,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.all(0),
      hintText: hintText,
      counter: null,
      counterText: "",
      hintStyle: MyTextStyle(
        textWeight: FontWeight.w400,
        textSize: ResponsiveFlutter.of(context).fontSize(1.8),
        textColor: appColors.lightDarkBlueColor,
      ),
    ),
  );
}

/// <<<----------- Add your commons widget hear ----------->>> ///

/// ----- Common TextField With Container -------------------->>>
Widget commonTextFieldContainer({
  required BuildContext context,
  TextEditingController? controller,
  Color? containerColor,
  String? hintText = "",
  TextInputType? inputType,
  TextInputAction? textInputAction,
  bool? obscureText = false,
  bool? isImage = true,
  bool? isShadow = true,
  bool? isMaxLines = false,
  bool? enabled = true,
  int? maxLines = 1,
  int? minLines = 1,
  String? image = "",
  Color? imageColor,
  ValueChanged<String>? onChange,
  Widget? suffixWidget,
}) {
  AppColors appColors = AppColors();
  return commonContainer(
    context: context,
    isHeight: !isMaxLines!,
    color: containerColor ?? appColors.whiteColor,
    isShadow: isShadow,
    child: Row(
      crossAxisAlignment: isMaxLines ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: isImage!,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).moderateScale(18)),
                child: Image.asset(
                  image!,
                  color: imageColor,
                  height: ResponsiveFlutter.of(context).verticalScale(18),
                  width: ResponsiveFlutter.of(context).verticalScale(18),
                ),
              ),
              Container(
                height: ResponsiveFlutter.of(context).verticalScale(46),
                width: ResponsiveFlutter.of(context).scale(1.4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColors.appColor.withOpacity(0.0),
                      appColors.appColor.withOpacity(0.3),
                      appColors.appColor.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: ResponsiveFlutter.of(context).verticalScale(isImage ? 10 : 15)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).moderateScale(isMaxLines ? 15 : 0)),
            child: commonTextField(
              context: context,
              hintText: hintText!,
              controller: controller,
              inputType: inputType ?? TextInputType.text,
              textInputAction: textInputAction ?? TextInputAction.next,
              onChange: onChange,
              obscureText: obscureText,
              isMaxLines: isMaxLines,
              maxLines: maxLines,
              minLines: minLines,
              enabled: enabled,
            ),
          ),
        ),
        SizedBox(width: ResponsiveFlutter.of(context).verticalScale(isMaxLines ? 15 : 0)),
        Center(child: suffixWidget ?? Container()),
      ],
    ),
  );
}

/// ----- Common Button -------------------->>>
Widget commonButton({
  required BuildContext context,
  String? title = "",
  bool? smallButton = false,
  bool? isBorder = false,
}) {
  AppColors appColors = AppColors();
  return Container(
    height: ResponsiveFlutter.of(context).verticalScale(smallButton! ? 38 : 48),
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isBorder! ? null : appColors.orangeColor,
      borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).moderateScale(isBorder ? 10 : 12)),
      border: isBorder ? Border.all(color: appColors.orangeColor, width: 1.8) : null,
    ),
    child: MyTextView(
      title!,
      textStyleNew: MyTextStyle(
        textWeight: FontWeight.bold,
        textSize: ResponsiveFlutter.of(context).fontSize(smallButton ? 2 : 2.2),
        textColor: isBorder ? appColors.darkBlueColor : appColors.whiteColor,
      ),
    ),
  );
}
