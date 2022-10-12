import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddPaymentScreen extends GetView<AddPaymentController> {
  const AddPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 6.w).copyWith(top: MediaQuery.of(Get.context!).padding.top + AppBar().preferredSize.height + 2.h),
              children: [
                SizedBox(height: 2.h),
                MyTextView(
                  "Choose a Payment Method",
                  textStyleNew: MyTextStyle(
                    textColor: appColors.darkTextColor,
                    textWeight: FontWeight.bold,
                    textSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      height: 27.33.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: appColors.appColorText, width: 0.2.h),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 2.w,
                            top: 2.w,
                            child: Image.asset(
                              ImagePath.checkMark,
                              width: 2.8.h,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.card,
                                  color: appColors.appColorText,
                                  width: 4.8.h,
                                ),
                                MyTextView(
                                  "Credit Card",
                                  textStyleNew: MyTextStyle(
                                    textColor: appColors.appColorText,
                                    textWeight: FontWeight.bold,
                                    textSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 27.33.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: appColors.lightGreyColor, width: 0.2.h),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagePath.payPal,
                            color: appColors.lightTextColor,
                            width: 4.2.h,
                          ),
                          MyTextView(
                            "Pay Pal",
                            textStyleNew: MyTextStyle(
                              textColor: appColors.lightTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 27.33.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: appColors.lightGreyColor, width: 0.2.h),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagePath.applePayment,
                            color: appColors.lightTextColor,
                            width: 4.2.h,
                          ),
                          MyTextView(
                            "Apple Pay",
                            textStyleNew: MyTextStyle(
                              textColor: appColors.lightTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.4.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Card Number",
                    hintText: "Input Card Number",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    controller: controller.cardNumberController,
                    isError: controller.cardNumberError.value,
                    hintColor: controller.cardNumberError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cardNumberError.value ? appColors.errorColor : appColors.darkTextColor,
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Card Holder Name",
                    hintText: "Input Name",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    controller: controller.cardHolderNameController,
                    isError: controller.cardHolderNameError.value,
                    hintColor: controller.cardHolderNameError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cardHolderNameError.value ? appColors.errorColor : appColors.darkTextColor,
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "Expiration Date",
                    hintText: "DD/MM/YYYY",
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.datetime,
                    controller: controller.expirationDateController,
                    isError: controller.expirationDateError.value,
                    hintColor: controller.expirationDateError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.expirationDateError.value ? appColors.errorColor : appColors.darkTextColor,
                    suffix: Padding(
                      padding: EdgeInsets.all(1.2.h),
                      child: Image.asset(
                        ImagePath.date,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 1.6.h),
                Obx(() {
                  return CustomTextField(
                    isTitle: true,
                    title: "CVV",
                    hintText: "Input CVV",
                    textInputAction: TextInputAction.done,
                    inputType: TextInputType.number,
                    controller: controller.cvvController,
                    isError: controller.cvvError.value,
                    hintColor: controller.cvvError.value ? appColors.errorColor : appColors.lightTextColor,
                    textColor: controller.cvvError.value ? appColors.errorColor : appColors.darkTextColor,
                    suffix: Padding(
                      padding: EdgeInsets.all(1.4.h),
                      child: Image.asset(
                        ImagePath.cardSmall,
                      ),
                    ),
                  );
                }),
                SizedBox(height: 1.8.h),
                Row(
                  children: [
                    MyTextView(
                      "Set as Primary Payment",
                      textStyleNew: MyTextStyle(
                        textColor: appColors.darkTextColor,
                        textWeight: FontWeight.bold,
                        textSize: 12.sp,
                      ),
                    ),
                    const Spacer(),
                    Obx(() {
                      return CupertinoSwitch(
                        value: controller.primaryPayment.value,
                        onChanged: (value) {
                          controller.primaryPayment.value = value;
                        },
                        thumbColor: CupertinoColors.white,
                        activeColor: appColors.appColorText,
                      );
                    }),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomButton(
                  onPressed: () {},
                  text: "Add Payment",
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
            const CustomAppBar(
              isBack: true,
              title: "Add Payment",
            ),
          ],
        ),
      ),
    );
  }
}
