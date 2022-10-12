import 'package:beep_car_wash/bottom_sheet/report.dart';
import 'package:beep_car_wash/bottom_sheet/reserve.dart';
import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NearestBeep extends StatelessWidget {
  const NearestBeep({super.key});

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors.whiteColor,
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
                  color: appColors.grayBorderColor,
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
                        "Nearest Beep",
                        textStyleNew: MyTextStyle(
                          textSize: 15.sp,
                          textWeight: FontWeight.bold,
                          textColor: appColors.darkTextColor,
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
                            textColor: appColors.darkTextColor,
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
                  children: [
                    CommonModel(index: 0.obs, image: ImagePath.navigation, title: "Navigation"),
                    CommonModel(index: 1.obs, image: ImagePath.qrScan, title: "Scan to Start"),
                    CommonModel(index: 2.obs, image: ImagePath.reserve, title: "Reserve"),
                    CommonModel(index: 3.obs, image: ImagePath.report, title: "Report"),
                  ]
                      .map((e) => GestureDetector(
                            onTap: () {
                              if (e.index!.value == 0) {
                              } else if (e.index!.value == 1) {
                              } else if (e.index!.value == 2) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: appColors.transparentColor,
                                  barrierColor: appColors.transparentColor,
                                  isScrollControlled: true,
                                  builder: (context) => StatefulBuilder(builder: (context, setState) => const Reserve()),
                                );
                              } else if (e.index!.value == 3) {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: appColors.transparentColor,
                                  barrierColor: appColors.transparentColor,
                                  isScrollControlled: true,
                                  builder: (context) => StatefulBuilder(builder: (context, setState) => Report()),
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
                                      color: e.index!.value == 0 ? appColors.appColorText : appColors.whiteColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: e.index!.value == 0 ? appColors.appColorText : appColors.grayBorderColor,
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
                                      textColor: appColors.lightTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
            ],
          ),
        ),
      ],
    );
  }
}
