import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WashHistoryScreen extends GetView<WashHistoryController> {
  const WashHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Stack(
      children: [
        ListView.separated(
          itemCount: 15,
          padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 2.h, bottom: MediaQuery.of(context).padding.bottom + 1.6.h),
          separatorBuilder: (context, index) => SizedBox(height: 2.h),
          itemBuilder: (context, index) => Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 2.4.h,
                    width: 2.4.h,
                    decoration: BoxDecoration(color: appColors.appColorText, shape: BoxShape.circle),
                  ),
                  SizedBox(width: 1.h),
                  MyTextView(
                    "13 September, 2022",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 11.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Padding(
                padding: EdgeInsets.only(left: 3.4.h),
                child: CustomContainer(
                  borderVisible: true,
                  isHeight: false,
                  containerColor: appColors.transparentColor,
                  borderRadius: 0.8.h,
                  padding: EdgeInsets.all(1.4.h).copyWith(bottom: 2.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.smallMachineImage,
                        height: 7.h,
                      ),
                      SizedBox(width: 2.h),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyTextView(
                                  "4:54 Min",
                                  textStyleNew: MyTextStyle(
                                    textColor: appColors.darkTextColor,
                                    textWeight: FontWeight.bold,
                                    textSize: 12.sp,
                                  ),
                                ),
                                MyTextView(
                                  "\$5.43",
                                  textStyleNew: MyTextStyle(
                                    textColor: appColors.appColorText,
                                    textWeight: FontWeight.bold,
                                    textSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImagePath.address,
                                  height: 2.2.h,
                                ),
                                SizedBox(width: 0.8.h),
                                Expanded(
                                  child: MyTextView(
                                    "1234 Barclay St, New York",
                                    isMaxLineWrap: true,
                                    textStyleNew: MyTextStyle(
                                      textColor: appColors.lightTextColor,
                                      textWeight: FontWeight.w600,
                                      textSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const CustomAppBar(
          title: Strings.washHistory,
        ),
      ],
    );
  }
}
