import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/scan_qr_code_screen/scan_qr_code_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  const ScanQRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
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
                          controller.controller!.toggleFlash();
                          // controller.controller!.pauseCamera();
                        },
                        child: Image.asset(
                          ImagePath.flashLight,
                          height: 3.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Scan the QR code on the\nmachine to start your wash",
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
                    onPressed: () {},
                    backgroundColor: AppColors.whiteColor,
                    text: "Enter Machine Code",
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
  }
}
