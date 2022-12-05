import 'dart:io';

import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/machine_responce_model.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/nearest_beep_sheet/nearest_beep_controller.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/report_sheet/report_sheet.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/reserve_sheet/reserve_sheet.dart';
import 'package:beep_car_wash/screens/scan_qr_code_screen/scan_qr_code_binding.dart';
import 'package:beep_car_wash/screens/scan_qr_code_screen/scan_qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NearestBeepSheet extends GetView<NearestBeepController> {
  final MachineData? machineData;

  const NearestBeepSheet({
    super.key,
    this.machineData,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(NearestBeepController());
    return GetBuilder<NearestBeepController>(
      initState: (state) {
        controller.isExpand.value = 0;
      },
      builder: (logic) {
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragStart: (details) {
                      printOkStatus("details -------------->>>  $details");

                      if (controller.isExpand.value == 0) {
                        controller.isExpand.value = 1;
                      } else if (controller.isExpand.value == 1) {
                        controller.isExpand.value = 2;
                      }
                    },
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Strings.nearestBeep,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.4.h),
                        Row(
                          children: [
                            Image.asset(ImagePath.address, height: 2.4.h),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                machineData!.address!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Obx(() {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: EdgeInsets.symmetric(vertical: controller.isExpand.value == 1 || controller.isExpand.value == 2 ? 1.5.h : 0),
                            height: controller.isExpand.value == 1
                                ? 8.h
                                : controller.isExpand.value == 2
                                    ? 20.h
                                    : 0,
                            child: controller.isExpand.value == 1 || controller.isExpand.value == 2
                                ? Row(
                                    children: [
                                      controller.isExpand.value == 2
                                          ? Row(
                                              children: [
                                                Image.asset(
                                                  ImagePath.machine,
                                                  height: 16.h,
                                                ),
                                                SizedBox(width: 6.w),
                                              ],
                                            )
                                          : Container(),
                                      Expanded(
                                        child: GridView.builder(
                                          itemCount: controller.machineData.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 120,
                                            childAspectRatio: 1.2,
                                          ),
                                          itemBuilder: (context, index) => Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                controller.machineData[index].image!,
                                                height: controller.isExpand.value == 1 ? 3.h : 3.6.h,
                                                width: controller.isExpand.value == 1 ? 3.h : 3.6.h,
                                              ),
                                              SizedBox(height: 0.4.h),
                                              Text(
                                                controller.isExpand.value == 1 ? controller.machineData[index].title!.replaceAll(" ", "\n") : controller.machineData[index].title!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: controller.isExpand.value == 1 ? 8.sp : 10.sp,
                                                  color: AppColors.greyColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          );
                        }),
                        Row(
                          children: [
                            Image.asset(
                              ImagePath.coin,
                              height: 2.4.h,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                machineData!.tagline!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.greyColor,
                                ),
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
                                onTap: () async {
                                  if (e.index! == 0) {
                                    String googleMapUrl;
                                    if (Platform.isAndroid) {
                                      googleMapUrl = "google.navigation:q=${machineData!.lat},${machineData!.long}&mode=d";
                                    } else {
                                      googleMapUrl = "https://www.google.com/maps/search/?api=1&query=${machineData!.lat},${machineData!.long}";
                                    }

                                    if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
                                      await launchUrl(Uri.parse(googleMapUrl));
                                    } else {
                                      Utils().showSnackBar(context: Get.context!, message: "Could not open the Map");
                                      throw 'Could not open the Map';
                                    }
                                  } else if (e.index == 1) {
                                    Get.to(() => const ScanQRCodeScreen(), binding: ScanQRCodeBinding(), arguments: ["Scan", machineData!.id!.toString()]);
                                  } else if (e.index == 2) {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: AppColors.transparentColor,
                                      barrierColor: AppColors.transparentColor,
                                      isScrollControlled: true,
                                      builder: (context) => ReserveSheet(machineId: machineData!.id!.toString()),
                                    );
                                  } else if (e.index == 3) {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: AppColors.transparentColor,
                                      barrierColor: AppColors.transparentColor,
                                      isScrollControlled: true,
                                      builder: (context) => ReportSheet(machineId: machineData!.id!.toString()),
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
                                      Text(
                                        e.title!,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.lightTextColor,
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
      },
    );
  }
}
