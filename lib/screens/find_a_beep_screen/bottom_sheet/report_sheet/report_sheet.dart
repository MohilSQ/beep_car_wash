import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/report_sheet/report_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ReportSheet extends GetView<ReportController> {
  const ReportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Report",
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  const Spacer(),
                  const CloseButton(),
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                "What issue are you facing?",
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
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
                      controller.reportList[index].isSelected!.value ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: AppColors.appColorText,
                      size: 3.h,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      controller.reportList[index].title!,
                      style: TextStyle(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Attach Photo",
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                height: 6.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 1.8.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(1.6.h),
                  border: Border.all(
                    color: AppColors.borderColor,
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
                    Text(
                      "Update",
                      style: TextStyle(
                        color: AppColors.appColorText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
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
                // hintColor: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.lightTextColor,
                // color: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                      backgroundColor: AppColors.transparentColor,
                      text: Strings.cancel,
                      color: AppColors.appColorText,
                      borderSide: BorderSide(
                        width: 0.1.h,
                        color: AppColors.lightGreyColor,
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
