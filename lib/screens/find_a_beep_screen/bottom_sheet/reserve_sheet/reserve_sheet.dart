import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/reserve_sheet/reserve_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ReserveSheet extends GetView<ReserveController> {
  const ReserveSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReserveController());
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
            children: [
              Row(
                children: [
                  Text(
                    "Reserve",
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
              SizedBox(height: 4.h),
              Text(
                "2\$ to reserve the machine\nfor 5 min",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
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
                      color: AppColors.redColor,
                      height: 2.4.h,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      "This action is non refundable",
                      style: TextStyle(
                        color: AppColors.redColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
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
