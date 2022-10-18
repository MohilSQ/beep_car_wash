import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HowItWorkScreen extends GetView<HowItWorkController> {
  const HowItWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: controller.howItWorkList.length,
          padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height, bottom: MediaQuery.of(context).padding.bottom + 3.h),
          itemBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 4.4.h),
              Image.asset(
                controller.howItWorkList[index].image!,
                height: 14.h,
              ),
              SizedBox(height: 4.4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: MyTextView(
                  controller.howItWorkList[index].title,
                  textStyleNew: MyTextStyle(
                    textColor: AppColors.darkTextColor,
                    textWeight: FontWeight.bold,
                    textSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 1.4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.checkMark,
                    height: 2.4.h,
                  ),
                  SizedBox(width: 1.4.h),
                  MyTextView(
                    "Lorem ipsum dolor sit amet, consectetur",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.checkMark,
                    height: 2.4.h,
                  ),
                  SizedBox(width: 1.4.h),
                  MyTextView(
                    "Lorem ipsum dolor sit amet, consectetur",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const CustomAppBar(
          title: Strings.howItWork,
        ),
      ],
    );
  }
}
