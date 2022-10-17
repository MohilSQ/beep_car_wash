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
  final double? textSize;
  final bool? isTitle;
  final String? title;
  final bool? enabled;
  final bool? isDense;
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
  final bool? isHight;
  final bool? borderVisible;
  final bool? containerVisible;
  final Widget? suffix;
  final EdgeInsets? padding;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.textColor,
    this.textSize,
    this.hintColor,
    this.isTitle = false,
    this.title,
    this.enabled = true,
    this.isDense = true,
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
    this.isHight = true,
    this.borderVisible = true,
    this.containerVisible = true,
    this.suffix,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle!
            ? MyTextView(
                title!,
                textStyleNew: MyTextStyle(
                  textColor: appColors.darkTextColor,
                  textWeight: FontWeight.bold,
                  textSize: 12.sp,
                ),
              )
            : const SizedBox(),
        isTitle! ? SizedBox(height: 1.h) : const SizedBox(),
        containerVisible!
            ? CustomContainer(
                borderVisible: borderVisible!,
                errorView: isError,
                isHeight: isHight,
                padding: padding,
                child: Row(
                  children: [
                    Expanded(child: textField()),
                    suffix ?? const SizedBox(),
                  ],
                ),
              )
            : textField(),
      ],
    );
  }

  Widget textField() {
    AppColors appColors = AppColors();
    return TextField(
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
        textSize: textSize ?? 12.sp,
        textColor: textColor ?? appColors.blackColor,
      ),
      decoration: InputDecoration(
        isDense: isDense,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(0),
        hintText: hintText,
        counter: null,
        counterText: "",
        hintStyle: MyTextStyle(
          textWeight: FontWeight.w600,
          textSize: textSize ?? 12.sp,
          textColor: hintColor ?? appColors.lightTextColor,
        ),
      ),
    );
  }
}
