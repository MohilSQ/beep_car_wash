import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/nearest_beep_sheet/nearest_beep_controller.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/report_sheet/report_sheet.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/reserve_sheet/reserve_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NearestBeepSheet extends GetView<NearestBeepController> {
  const NearestBeepSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NearestBeepController());
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
          ),
          child: Column(
            children: [
              SizedBox(height: 1.8.h),
              Container(
                height: 0.6.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: AppColors.grayBorderColor,
                ),
              ),
              SizedBox(height: 1.4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MyTextView(
                        Strings.nearestBeep,
                        textStyleNew: MyTextStyle(
                          textSize: 15.sp,
                          textWeight: FontWeight.bold,
                          textColor: AppColors.darkTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.4.h),
                    Row(
                      children: [
                        Image.asset(ImagePath.address, height: 2.4.h),
                        SizedBox(width: 2.w),
                        MyTextView(
                          "1234 Barclay St, New York",
                          textStyleNew: MyTextStyle(
                            textSize: 12.sp,
                            textWeight: FontWeight.w600,
                            textColor: AppColors.darkTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              Divider(height: 0.6.h),
              SizedBox(height: 2.h),
              SizedBox(
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.actionList
                      .map((e) => GestureDetector(
                            onTap: () {
                              if (e.index! == 0) {
                              } else if (e.index == 1) {
                              } else if (e.index == 2) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppColors.transparentColor,
                                  barrierColor: AppColors.transparentColor,
                                  isScrollControlled: true,
                                  builder: (context) => StatefulBuilder(builder: (context, setState) => const ReserveSheet()),
                                );
                              } else if (e.index == 3) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppColors.transparentColor,
                                  barrierColor: AppColors.transparentColor,
                                  isScrollControlled: true,
                                  builder: (context) => StatefulBuilder(builder: (context, setState) => const ReportSheet()),
                                );
                              }
                            },
                            child: SizedBox(
                              width: 22.w,
                              child: Column(
                                children: [
                                  Container(
                                    height: 6.6.h,
                                    width: 6.6.h,
                                    decoration: BoxDecoration(
                                      color: e.index == 0 ? AppColors.appColorText : AppColors.whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: e.index == 0 ? AppColors.appColorText : AppColors.grayBorderColor,
                                        width: 0.1.h,
                                      ),
                                    ),
                                    child: Wrap(
                                      runAlignment: WrapAlignment.center,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        Image.asset(
                                          e.image!,
                                          height: 3.2.h,
                                          width: 3.2.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.6.h),
                                  MyTextView(
                                    e.title,
                                    textStyleNew: MyTextStyle(
                                      textSize: 10.sp,
                                      textWeight: FontWeight.w600,
                                      textColor: AppColors.lightTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
            ],
          ),
        ),
      ],
    );
  }
}
