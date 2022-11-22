import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WashHistoryScreen extends GetView<WashHistoryController> {
  const WashHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WashHistoryController>(
        init: WashHistoryController(),
        initState: (state) {
          controller.getWashHistoryResponseAPI();
        },
        builder: (logic) {
          return Stack(
            children: [
              controller.noData!.value.isNotEmpty
                  ? Center(
                      child: Text(
                        controller.noData!.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.washHistoryResponseModel == null ? 0 : controller.washHistoryResponseModel!.data!.length,
                      padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 2.h, bottom: MediaQuery.of(context).padding.bottom + 1.6.h),
                      separatorBuilder: (context, index) => SizedBox(height: 2.h),
                      itemBuilder: (context, index) {
                        var obj = controller.washHistoryResponseModel!.data![index];

                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 2.4.h,
                                  width: 2.4.h,
                                  decoration: BoxDecoration(color: AppColors.appColorText, shape: BoxShape.circle),
                                ),
                                SizedBox(width: 1.h),
                                Text(
                                  DateFormat("d MMMM yyyy").format(DateTime.parse(controller.utils.utcToLocal(obj.washStart!))),
                                  style: TextStyle(
                                    color: AppColors.lightTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.sp,
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
                                containerColor: AppColors.transparentColor,
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
                                              Text(
                                                "${DateTime.parse(controller.utils.utcToLocal(obj.washStart!)).difference(DateTime.parse(controller.utils.utcToLocal(obj.washEnd!))).inMinutes} Min",
                                                style: TextStyle(
                                                  color: AppColors.darkTextColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              Text(
                                                "\$${obj.amount ?? 0.0}",
                                                style: TextStyle(
                                                  color: AppColors.appColorText,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
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
                                                child: Text(
                                                  obj.address!,
                                                  style: TextStyle(
                                                    color: AppColors.lightTextColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp,
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
                        );
                      },
                    ),
              const CustomAppBar(
                title: Strings.washHistory,
              ),
            ],
          );
        });
  }
}
