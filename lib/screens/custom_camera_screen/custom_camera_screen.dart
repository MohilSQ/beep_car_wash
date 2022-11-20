import 'dart:io';

import 'package:beep_car_wash/commons/image_path.dart';
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
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final aspectRatio = 3 / 4;
    return GetBuilder<CustomCameraController>(
      builder: (logic) {
        return Scaffold(
          body: controller.isCameraInitialized
              ? Stack(
                  children: [
                    Transform.scale(
                      scale: controller.controller!.value.aspectRatio / deviceRatio,
                      child: Center(
                          child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: controller.controller!.buildPreview(),
                      )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 1.h),
                        child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  XFile? rawImage = await controller.takePicture();
                                  File imageFile = File(rawImage!.path);
                                  print("fileFormat------>>>$imageFile");
                                  Get.back(result: imageFile);
                                  // int currentUnix = DateTime.now().millisecondsSinceEpoch;
                                  // final directory = await getApplicationDocumentsDirectory();
                                  // String fileFormat = imageFile.path.split('.').last;
                                  // await imageFile.copy(
                                  //   '${directory.path}/$currentUnix.$fileFormat',
                                  // );
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      ImagePath.takeImage,
                                      height: 8.h,
                                      width: 8.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.isCameraInitialized = false;
                                  controller.onNewCameraSelected(
                                    cameras[controller.isRearCameraSelected ? 0 : 1],
                                  );

                                  controller.isRearCameraSelected = !controller.isRearCameraSelected;
                                  controller.update();
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(0.9.h),
                                      height: 6.h,
                                      width: 6.h,
                                      child: Image.asset(
                                        ImagePath.flipCamera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
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
                              BackButton(
                                color: AppColors.whiteColor,
                              ),
                              const Spacer(),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  print("object");

                                  controller.update();
                                  // controller.controller!.pauseCamera();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  height: 4.5.h,
                                  width: 4.5.h,
                                  child: Image.asset(
                                    ImagePath.flashLight,
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
                )
              : Container(),
        );
      },
    );
  }
}
