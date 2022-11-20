import 'package:beep_car_wash/screens/biling_screen/billing_controller.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../commons/app_colors.dart';
import '../../commons/image_path.dart';
import '../../commons/strings.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../feedback_screen/feedback_binding.dart';
import '../feedback_screen/feedback_screen.dart';

class BillingScreen extends GetView<BillingController> {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillingController>(
      builder: (logic) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            top: false,
            child: Stack(
              children: [
                const CustomAppBar(
                  title: "Billing",
                  isButton: false,
                ),
                ListView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 4.h,
                    right: 4.w,
                    left: 4.w,
                  ),
                  children: [
                    Text(
                      "Wash Completed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomContainer(
                            borderVisible: true,
                            padding: EdgeInsets.all(3.h),
                            isHeight: false,
                            child: Column(
                              children: [
                                Image.asset(
                                  ImagePath.time,
                                  height: 2.6.h,
                                  width: 2.6.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 1.4.h),
                                Text(
                                  "01:35",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: CustomContainer(
                            borderVisible: true,
                            padding: EdgeInsets.all(3.h),
                            isHeight: false,
                            child: Column(
                              children: [
                                Image.asset(
                                  ImagePath.wallet,
                                  height: 2.6.h,
                                  width: 2.6.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 1.4.h),
                                Text(
                                  "\$4.45",
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Divider(height: 0.8.h),
                    SizedBox(height: 3.h),
                    Text(
                      "Tue, Sep 13",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Image.asset(ImagePath.address, height: 2.4.h),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            "1234 Barclay St, New York",
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
                    SizedBox(height: 2.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1.h),
                      child: SizedBox(
                        height: 24.h,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: false,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: const CameraPosition(target: LatLng(40.7127753, -74.0059728), zoom: 18),
                          // initialCameraPosition: CameraPosition(target: LatLng(Constants.latitude, Constants.longitude), zoom: 18),
                          markers: Set<Marker>.of(controller.markers.values),

                          onMapCreated: (GoogleMapController googleMapController) {
                            // controller.mapController = googleMapController;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: CustomButton(
                          onPressed: () {
                            print("object----???");
                            openBottomApplyCodeSheet(context);
                          },
                          backgroundColor: AppColors.whiteColor,
                          text: "Apply Coupon",
                          color: AppColors.appColorText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.h),
                        child: CustomButton(
                          onPressed: () {
                            // controller.stopMachineAPI(washId!);
                            Get.to(() => const FeedbackScreen(), binding: FeedbackBinding());
                          },
                          text: "Okay",
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                    ],
                  ),
                ),
              ],
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
                        Strings.promo,
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
                    Strings.enterCouponCode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    Strings.enterCouponCodedic,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.greyColor.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      fontSize: 9.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  CustomTextField(
                    controller: controller.code,
                    hintText: Strings.enterCode,
                  ),
                  SizedBox(height: 5.h),
                  CustomButton(
                    onPressed: () {
                      if (controller.code.text.trim().isEmpty) {
                        controller.utils.showSnackBar(message: "Please enter code", context: context);
                      } else {
                        Get.back();
                      }
                    },
                    // backgroundColor: AppColors.appColor,
                    text: Strings.apply,
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
