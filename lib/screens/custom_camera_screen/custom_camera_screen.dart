import 'dart:io';

import 'package:beep_car_wash/commons/common_dialog.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../commons/app_colors.dart';
import '../../commons/strings.dart';
import '../../main.dart';
import 'custom_camera_controller.dart';

class CustomCameraScreen extends GetView<CustomCameraController> {
  const CustomCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomCameraController>(
      assignId: true,
      initState: (state) {
        Utils.lightStatusBar();
        Future.delayed(
          const Duration(milliseconds: 200),
          () => openBottomApplyCodeSheet(Get.context!),
        );
      },
      dispose: (state) {
        Utils.darkStatusBar();
        controller.controller!.dispose();
      },
      builder: (logic) {
        return WillPopScope(
          onWillPop: () {
            messageDialog(
              massage: "Please first tack machine photo and complete the payment.",
              btnName: "Ok",
            );
            return Future(() => false);
          },
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              top: false,
              child: Container(
                color: AppColors.blackColor,
                child: Stack(
                  children: [
                    !controller.isCameraInitialized
                        ? Container(color: AppColors.blackColor)
                        : Container(
                            height: 86.h,
                            width: controller.controller!.value.previewSize!.width,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                            child: CameraPreview(controller.controller!),
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 3.h),
                        child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  XFile? rawImage = await controller.takePicture();
                                  File imageFile = File(rawImage!.path);
                                  controller.uploadMachinePhotoAPI(imageFile);
                                },
                                child: Image.asset(
                                  ImagePath.takeImage,
                                  height: 8.h,
                                  width: 8.h,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.isCameraInitialized = false;
                                  if (controller.cameraSelected.value == 0) {
                                    controller.cameraSelected.value = 1;
                                    controller.onNewCameraSelected(cameras[1]);
                                  } else {
                                    controller.cameraSelected.value = 0;
                                    controller.onNewCameraSelected(cameras[0]);
                                  }
                                  controller.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0.9.h),
                                  height: 6.h,
                                  width: 6.h,
                                  child: Image.asset(
                                    ImagePath.flipCamera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 2.h, right: 3.h),
                          child: Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  if (controller.controller!.value.flashMode == FlashMode.torch) {
                                    controller.controller!.setFlashMode(FlashMode.off);
                                  } else {
                                    controller.controller!.setFlashMode(FlashMode.torch);
                                  }
                                  controller.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  height: 4.5.h,
                                  width: 4.5.h,
                                  child: Image.asset(
                                    !controller.isCameraInitialized
                                        ? ImagePath.flashLight
                                        : controller.controller!.value.flashMode == FlashMode.torch
                                            ? ImagePath.flashLightYellow
                                            : ImagePath.flashLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          Strings.customCameraStr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  openBottomApplyCodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparentColor,
      barrierColor: AppColors.blackColor.withOpacity(0.3),
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.endWash,
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
                    Strings.important,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImagePath.termsOfService,
                        color: AppColors.yellowColor,
                        height: 2.4.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          Strings.importantPoint1,
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImagePath.termsOfService,
                        color: AppColors.yellowColor,
                        height: 2.4.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          Strings.importantPoint2,
                          softWrap: true,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                      color: const Color(0xFFFFE7E2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImagePath.termsOfService,
                          color: AppColors.redColor,
                          height: 2.4.h,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            Strings.importantPointWarring,
                            softWrap: true,
                            style: TextStyle(
                              color: AppColors.redColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomButton(
                    onPressed: () {
                      Get.back();
                    },
                    text: Strings.okay,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
