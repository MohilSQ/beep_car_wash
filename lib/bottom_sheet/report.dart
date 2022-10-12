import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Report extends StatelessWidget {
  Report({super.key});

  List<CommonModel> reportList = [
    CommonModel(isSelected: true.obs, title: "Water/Foam pump"),
    CommonModel(isSelected: false.obs, title: "Air Blower"),
    CommonModel(isSelected: false.obs, title: "Vaccum"),
    CommonModel(isSelected: false.obs, title: "Machine won’t turn on"),
    CommonModel(isSelected: false.obs, title: "Other Issue"),
  ];
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            color: appColors.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MyTextView(
                    "Report",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 15.sp,
                    ),
                  ),
                  const Spacer(),
                  const CloseButton(),
                ],
              ),
              SizedBox(height: 1.h),
              MyTextView(
                "What issue are you facing?",
                isMaxLineWrap: true,
                textStyleNew: MyTextStyle(
                  textColor: appColors.darkTextColor,
                  textWeight: FontWeight.bold,
                  textSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(height: 1.h),
                itemBuilder: (context, index) => Row(
                  children: [
                    Icon(
                      reportList[index].isSelected!.value ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: appColors.appColorText,
                      size: 3.h,
                    ),
                    SizedBox(width: 2.w),
                    MyTextView(
                      reportList[index].title,
                      isMaxLineWrap: true,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.darkTextColor,
                        textWeight: FontWeight.w600,
                        textSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              MyTextView(
                "Attach Photo",
                isMaxLineWrap: true,
                textStyleNew: MyTextStyle(
                  textColor: appColors.darkTextColor,
                  textWeight: FontWeight.bold,
                  textSize: 14.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                height: 6.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 1.8.h),
                decoration: BoxDecoration(
                  color: appColors.whiteColor,
                  borderRadius: BorderRadius.circular(1.6.h),
                  border: Border.all(
                    color: appColors.borderColor,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImagePath.tablerPhoto,
                      height: 3.3.h,
                    ),
                    const Spacer(),
                    MyTextView(
                      "Update",
                      isMaxLineWrap: true,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.appColorText,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                isTitle: true,
                isHight: false,
                title: "Write a Comment",
                hintText: "Input Text",
                textInputAction: TextInputAction.next,
                inputType: TextInputType.number,
                controller: TextEditingController(),
                minLines: 5,
                isMaxLines: true,
                padding: EdgeInsets.all(1.8.h),
                // isError: controller.phoneNumberError.value,
                // hintColor: controller.phoneNumberError.value ? appColors.errorColor : appColors.lightTextColor,
                // textColor: controller.phoneNumberError.value ? appColors.errorColor : appColors.darkTextColor,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      elevation: 0,
                      backgroundColor: appColors.transparentColor,
                      text: Strings.cancel,
                      textColor: appColors.appColorText,
                      borderSide: BorderSide(
                        width: 0.1.h,
                        color: appColors.lightGreyColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      elevation: 0,
                      text: Strings.submit,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ],
    );
  }
}
