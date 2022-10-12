import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Reserve extends StatelessWidget {
  const Reserve({super.key});

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
            children: [
              Row(
                children: [
                  MyTextView(
                    "Reserve",
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
              SizedBox(height: 4.h),
              MyTextView(
                "2\$ to reserve the machine\nfor 5 min",
                isMaxLineWrap: true,
                textAlignNew: TextAlign.center,
                textStyleNew: MyTextStyle(
                  textColor: appColors.darkTextColor,
                  textWeight: FontWeight.bold,
                  textSize: 20.sp,
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                height: 6.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.h),
                  color: const Color(0xFFFFE7E2),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImagePath.termsOfService,
                      color: appColors.redColor,
                      height: 2.4.h,
                    ),
                    SizedBox(width: 3.w),
                    MyTextView(
                      "This action is non refundable",
                      isMaxLineWrap: true,
                      textStyleNew: MyTextStyle(
                        textColor: appColors.redColor,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
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
                      text: "Reserve Now",
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
