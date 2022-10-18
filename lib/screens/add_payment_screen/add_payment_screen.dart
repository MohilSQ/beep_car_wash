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
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 6.w).copyWith(top: MediaQuery.of(Get.context!).padding.top + AppBar().preferredSize.height + 2.h),
              children: [
                SizedBox(height: 1.4.h),
                MyTextView(
                  "Choose a Payment Method",
                  textStyleNew: MyTextStyle(
                    textColor: AppColors.darkTextColor,
                    textWeight: FontWeight.bold,
                    textSize: 14.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Container(
                      height: 26.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7FBF4),
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: AppColors.appColorText, width: 0.15.h),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 2.w,
                            top: 2.w,
                            child: Image.asset(
                              ImagePath.checkMark,
                              width: 2.2.h,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.6.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImagePath.card,
                                    color: AppColors.appColorText,
                                    width: 4.h,
                                  ),
                                  MyTextView(
                                    "Credit Card",
                                    textStyleNew: MyTextStyle(
                                      textColor: AppColors.appColorText,
                                      textWeight: FontWeight.bold,
                                      textSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 26.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: AppColors.lightGreyColor, width: 0.1.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImagePath.payPal,
                              color: AppColors.lightTextColor,
                              width: 3.6.h,
                            ),
                            MyTextView(
                              "Pay Pal",
                              textStyleNew: MyTextStyle(
                                textColor: AppColors.lightTextColor,
                                textWeight: FontWeight.bold,
                                textSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 26.w,
                      width: 27.33.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.8.h),
                        border: Border.all(color: AppColors.lightGreyColor, width: 0.1.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.4.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImagePath.applePayment,
                              color: AppColors.lightTextColor,
                              width: 3.6.h,
                            ),
                            MyTextView(
                              "Apple Pay",
                              textStyleNew: MyTextStyle(
                                textColor: AppColors.lightTextColor,
                                textWeight: FontWeight.bold,
                                textSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
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
                    hintColor: controller.cardNumberError.value ? AppColors.errorColor : AppColors.lightTextColor,
                    textColor: controller.cardNumberError.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                    hintColor: controller.cardHolderNameError.value ? AppColors.errorColor : AppColors.lightTextColor,
                    textColor: controller.cardHolderNameError.value ? AppColors.errorColor : AppColors.darkTextColor,
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
                    hintColor: controller.expirationDateError.value ? AppColors.errorColor : AppColors.lightTextColor,
                    textColor: controller.expirationDateError.value ? AppColors.errorColor : AppColors.darkTextColor,
                    suffix: Image.asset(
                      ImagePath.date,
                      height: 3.2.h,
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
                    hintColor: controller.cvvError.value ? AppColors.errorColor : AppColors.lightTextColor,
                    textColor: controller.cvvError.value ? AppColors.errorColor : AppColors.darkTextColor,
                    suffix: Image.asset(
                      ImagePath.cardSmall,
                      width: 3.h,
                    ),
                  );
                }),
                SizedBox(height: 1.8.h),
                Row(
                  children: [
                    MyTextView(
                      "Set as Primary Payment",
                      textStyleNew: MyTextStyle(
                        textColor: AppColors.darkTextColor,
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
                        activeColor: AppColors.appColorText,
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
