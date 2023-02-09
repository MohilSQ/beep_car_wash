import 'dart:io';

import 'package:beep_car_wash/commons/common_dialog.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/response_model/stop_machine_response_model.dart';
import 'package:beep_car_wash/paypal_service/paypal_payment.dart';
import 'package:beep_car_wash/screens/billing_screen/billing_controller.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:sizer/sizer.dart';

import '../../commons/app_colors.dart';
import '../../commons/image_path.dart';
import '../../commons/strings.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class BillingScreen extends GetView<BillingController> {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils.darkStatusBar();
    return GetBuilder<BillingController>(
      initState: (state) {
        controller.stopMachineResponseModel = Get.arguments[2] ? Get.arguments[0] : StopMachineResponseModel.fromJson(Get.arguments[0]);
        controller.washId.value = Get.arguments[1];
        controller.setMarker(double.parse(controller.stopMachineResponseModel!.data?.machineLat ?? ""), double.parse(controller.stopMachineResponseModel!.data?.machineLong ?? ""));
        controller.trxAmount.value = controller.stopMachineResponseModel!.data!.amount!;
      },
      builder: (logic) {
        return WillPopScope(
          onWillPop: () {
            messageDialog(
              massage: "Please first complete the payment.",
              btnName: "Ok",
            );
            return Future(() => false);
          },
          child: Scaffold(
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
                                    controller.stopMachineResponseModel!.data?.washTime ?? "",
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
                                    "\$${controller.stopMachineResponseModel!.data?.amount ?? ""}",
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
                        DateFormat.MMMEd().format(DateTime.now()),
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
                              controller.stopMachineResponseModel!.data?.address ?? "",
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
                            initialCameraPosition: CameraPosition(target: LatLng(double.parse(controller.stopMachineResponseModel!.data?.machineLat ?? ""), double.parse(controller.stopMachineResponseModel!.data?.machineLong ?? "")), zoom: 18),
                            markers: Set<Marker>.of(controller.markers),
                            onMapCreated: (GoogleMapController googleMapController) {},
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            onPressed: () {
                              openBottomApplyCodeSheet(context);
                            },
                            backgroundColor: AppColors.transparentColor,
                            text: "Apply Coupon",
                            color: AppColors.appColorText,
                            elevation: 0,
                            borderSide: BorderSide(color: AppColors.lightGreyColor, width: 0.8),
                          ),
                          SizedBox(height: 2.h),
                          if (controller.stopMachineResponseModel != null) ...[
                            controller.stopMachineResponseModel!.data!.paymentSourceType! == "1"
                                ? CustomButton(
                                    onPressed: () {
                                      controller.saveWashBillByCreditCardAPI();
                                    },
                                    text: "Okay",
                                  )
                                : controller.stopMachineResponseModel!.data!.paymentSourceType! == "2"
                                    ? CustomButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) => PaypalPayment(
                                                sandboxMode: true,
                                                amount: controller.trxAmount.value,
                                                onFinish: (number) async {
                                                  debugPrint('order id: $number');
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor: const Color(0xFFffc439),
                                        image: ImagePath.payPalLogo,
                                        color: AppColors.appColorText,
                                        elevation: 0,
                                        borderRadius: 5,
                                      )
                                    : Platform.isIOS
                                        ? ApplePayButton(
                                            paymentConfigurationAsset: 'apple_pay.json',
                                            paymentItems: [
                                              PaymentItem(
                                                label: 'Total',
                                                amount: controller.trxAmount.value,
                                                status: PaymentItemStatus.final_price,
                                              )
                                            ],
                                            height: 6.h,
                                            width: MediaQuery.of(context).size.width,
                                            style: ApplePayButtonStyle.black,
                                            onPaymentResult: (result) {
                                              printAction("result -------->>> ${result["token"]}");
                                              controller.trxId.value = result["token"];
                                              controller.saveWashBillByUPIAPI();
                                            },
                                            onError: (error) {
                                              printError("result -------->>> $error");
                                            },
                                            loadingIndicator: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          )
                                        :

                                        /// TODO: Google Pay Note
                                        /// NOTE: To live google pay change "environment": "TEST", To "environment": "PRODUCTION", in google_pay.json file
                                        /// And change test "merchantId" to your "merchantId" and test "merchantName" to your "merchantName"
                                        /// "merchantInfo": {
                                        ///     "merchantId": "01234567890123456789",
                                        ///     "merchantName": "Example Merchant Name"
                                        /// },
                                        GooglePayButton(
                                            paymentConfigurationAsset: 'google_pay.json',
                                            paymentItems: [
                                              PaymentItem(
                                                label: 'Total',
                                                amount: controller.trxAmount.value,
                                                status: PaymentItemStatus.final_price,
                                              )
                                            ],
                                            width: MediaQuery.of(context).size.width,
                                            type: GooglePayButtonType.pay,
                                            onPaymentResult: (result) {
                                              printAction("result -------->>> $result");
                                              controller.trxId.value = result["paymentMethodData"]["tokenizationData"]["token"];
                                              controller.saveWashBillByUPIAPI();
                                            },
                                            onError: (error) {
                                              printError("result -------->>> $error");
                                            },
                                            loadingIndicator: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ),
                          ],
                          SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                        ],
                      ),
                    ),
                  ),
                ],
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
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Wrap(
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
                      Strings.enterCouponCodeDic,
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
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: 5.h),
                    CustomButton(
                      onPressed: () {
                        if (controller.code.text.trim().isEmpty) {
                          controller.utils.showSnackBar(message: "Please enter code", context: context);
                        } else {
                          controller.verifyCouponCodeAPI();
                        }
                      },
                      text: Strings.apply,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => UsePaypal(
        sandboxMode: true,
        clientId: "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
        secretKey: "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: const [
          {
            "amount": {
              "total": '0.1',
              "currency": "USD",
              "details": {
                "subtotal": '0.1',
                "shipping": '0',
                "shipping_discount": 0,
              }
            },
            "description": "The payment transaction description.",
            // "item_list": {
            //   "items": [
            //     {
            //       "name": "Beep Car Wash",
            //       "price": '10.12',
            //       "currency": "USD",
            //     }
            //   ],
            // }
          }
        ],
        note: "Contact us for any questions on your car wash.",
        onSuccess: (Map params) async {
          printOkStatus("onSuccess: $params");
        },
        onError: (error) {
          printError("onError: $error");
        },
        onCancel: (params) {
          printWarning('cancelled: $params');
        },
      ),
    ),
  );*/
