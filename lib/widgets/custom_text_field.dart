import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final String? hintText;
  final Color? hintColor;
  final Color? textColor;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormat;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final bool? isMaxLines;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? isError;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.textColor,
    this.hintColor,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.inputType = TextInputType.text,
    this.inputFormat,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.focusNode,
    this.isMaxLines = false,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.isError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return CustomContainer(
      isError: isError,
      child: TextField(
        controller: controller,
        cursorColor: appColors.appColor,
        cursorWidth: 2,
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
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        maxLines: isMaxLines! ? null : maxLines,
        maxLength: maxLength,
        minLines: minLines,
        inputFormatters: inputFormat,
        style: MyTextStyle(
          textWeight: FontWeight.w600,
          textSize: 12.sp,
          textColor: textColor ?? appColors.blackColor,
        ),
        decoration: InputDecoration(
          isDense: false,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(0),
          hintText: hintText,
          counter: null,
          counterText: "",
          hintStyle: MyTextStyle(
            textWeight: FontWeight.w600,
            textSize: 12.sp,
            textColor: hintColor ?? appColors.lightTextColor,
          ),
        ),
      ),
    );
  }
}
