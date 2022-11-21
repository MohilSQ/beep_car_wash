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
        controller.isDragMore.value = false;
        controller.isDrag.value = false;
        controller.update();
      },
      builder: (logic) {
        return Wrap(
          children: [
            GestureDetector(
              onVerticalDragStart: (details) {
                if (!controller.isDragMore.value) {
                  if (controller.isDrag.value) {
                    controller.isDragMore.value = true;
                    controller.isDrag.value = false;
                  } else {
                    controller.isDrag.value = true;
                  }
                } else {
                  controller.isDragMore.value = false;
                  controller.isDrag.value = true;
                }
                controller.update();
              },
              child: Container(
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
                          Visibility(
                            visible: controller.isDrag.value,
                            child: AnimatedContainer(
                              width: MediaQuery.of(context).size.width - 4.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Column(
                                children: [
                                  SizedBox(height: 1.6.h),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.droplet,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Spotless\nWater",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.bubble,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Triple\nFoam",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.wind,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Air\nDryer",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.vaccum,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Vacuum\nCleaner",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.6.h),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: controller.isDragMore.value,
                            child: AnimatedContainer(
                              width: MediaQuery.of(context).size.width - 4.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Column(
                                children: [
                                  SizedBox(height: 1.6.h),
                                  Row(
                                    children: [
                                      Image.asset(
                                        ImagePath.machine,
                                        height: 16.h,
                                        // width: 3.h,
                                      ),
                                      SizedBox(width: 6.w),
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.wind,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Air Dryer",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Image.asset(
                                            ImagePath.droplet,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Spotless Water",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 6.w),
                                      Column(
                                        children: [
                                          Image.asset(
                                            ImagePath.vaccum,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Vaccum Cleaner",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Image.asset(
                                            ImagePath.bubble,
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          SizedBox(height: 0.4.h),
                                          Text(
                                            "Triple Foam",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              color: AppColors.greyColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.6.h),
                                ],
                              ),
                            ),
                          ),
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
                                      // String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=${machineData!.lat},${machineData!.long}";
                                      String googleMapUrl = "google.navigation:q=${machineData!.lat},${machineData!.long}&mode=d";

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
            ),
          ],
        );
      },
    );
  }
}
