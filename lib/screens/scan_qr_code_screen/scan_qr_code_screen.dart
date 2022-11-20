import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/scan_qr_code_screen/scan_qr_code_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

import '../../commons/strings.dart';

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  const ScanQRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanQrCodeController>(
      assignId: true,
      dispose: (state) {
        controller.qrViewController!.dispose();
      },
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: Stack(
              children: [
                QRView(
                  key: controller.qrKey,
                  onQRViewCreated: controller.onQRViewCreated,
                  cameraFacing: CameraFacing.back,
                  onPermissionSet: (p0, p1) {
                    printAction("dvfjsdvfjsvdjsgvjksbvjkvsvbskbskjbfskdjb");
                  },
                  overlay: QrScannerOverlayShape(
                    borderRadius: 3.h,
                    borderColor: AppColors.whiteColor,
                    borderWidth: 6,
                    overlayColor: AppColors.lightGreyColor.withOpacity(0.5),
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
                            onTap: () {
                              Get.find<ScanQrCodeController>().qrViewController!.toggleFlash();
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
                      Strings.scanWrCodeToStart,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: CustomButton(
                        onPressed: () {
                          controller.qrViewController!.pauseCamera();
                          openBottomEnterMachineCodeSheet(context);
                        },
                        backgroundColor: AppColors.whiteColor,
                        text: Strings.enterMachineCode,
                        color: AppColors.appColorText,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  openBottomEnterMachineCodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparentColor,
      barrierColor: AppColors.transparentColor,
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
                        Strings.enterMachineCode,
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
                    Strings.enterBeepCode,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: controller.code,
                    hintText: Strings.enterCode,
                    inputType: TextInputType.number,
                    inputFormat: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  SizedBox(height: 5.h),
                  CustomButton(
                    onPressed: () {
                      if (controller.code.text.trim().isEmpty) {
                        controller.utils.showSnackBar(message: Strings.vMachineCode, context: context);
                      } else {
                        if (controller.screen.value == "Report") {
                          controller.reportScanToStartAPI(true);
                        } else {
                          controller.scanToStartAPI();
                        }
                      }
                    },
                    // backgroundColor: AppColors.appColor,
                    text: Strings.verifyNumber,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).then((value) {
      controller.qrViewController!.resumeCamera();
      if (value != null) {
        Get.back(result: value);
      }
    });
  }
}
