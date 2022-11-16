import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../commons/card_validation.dart';

class AddPaymentScreen extends GetView<AddPaymentController> {
  const AddPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPaymentController>(
      init: AddPaymentController(),
      builder: (logic) {
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
                    Text(
                      Strings.chooseAPaymentMethod,
                      style: TextStyle(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    SizedBox(
                      height: 26.w,
                      child: ListView.separated(
                        itemCount: controller.paymentMethodList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(width: 3.w),
                        itemBuilder: (context, index) => Obx(() {
                          return GestureDetector(
                            onTap: () {
                              for (int i = 0; i < controller.paymentMethodList.length; i++) {
                                if (index == i) {
                                  controller.primaryPaymentSelectNumber.value = index;
                                  controller.paymentMethodList[i].isSelected!.value = true;
                                } else {
                                  controller.paymentMethodList[i].isSelected!.value = false;
                                }
                              }
                            },
                            child: Container(
                              height: 26.w,
                              width: 27.33.w,
                              decoration: BoxDecoration(
                                color: controller.paymentMethodList[index].isSelected!.value ? const Color(0xFFE7FBF4) : AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.8.h),
                                border: Border.all(
                                  color: controller.paymentMethodList[index].isSelected!.value ? AppColors.appColorText : AppColors.lightGreyColor,
                                  width: controller.paymentMethodList[index].isSelected!.value ? 0.15.h : 0.1.h,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  if (controller.paymentMethodList[index].isSelected!.value)
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
                                            controller.paymentMethodList[index].image!,
                                            color: controller.paymentMethodList[index].isSelected!.value ? AppColors.appColorText : AppColors.lightTextColor,
                                            width: 4.h,
                                            height: 4.h,
                                          ),
                                          Text(
                                            controller.paymentMethodList[index].title!,
                                            style: TextStyle(
                                              color: controller.paymentMethodList[index].isSelected!.value ? AppColors.appColorText : AppColors.lightTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 2.4.h),
                    Obx(() {
                      return controller.paymentMethodList[0].isSelected!.value
                          ? Column(
                              children: [
                                Obx(() {
                                  return CustomTextField(
                                    isTitle: true,
                                    title: Strings.cardNumber,
                                    hintText: Strings.inputCardNumber,
                                    textInputAction: TextInputAction.next,
                                    inputType: TextInputType.number,
                                    controller: controller.cardNumberController,
                                    isError: controller.cardNumberError.value,
                                    hintColor: controller.cardNumberError.value ? AppColors.errorColor : AppColors.lightTextColor,
                                    color: controller.cardNumberError.value ? AppColors.errorColor : AppColors.darkTextColor,
                                    onChange: (val) {
                                      if (val.isNotEmpty) {
                                        for (int i = 0; i < val.length; i++) {
                                          controller.cardNumber.value = i + 1;
                                        }
                                      }
                                      controller.update();
                                    },
                                    inputFormat: [
                                      CreditCardNumberInputFormatter(),
                                    ],
                                  );
                                }),
                                SizedBox(height: 1.6.h),
                                Obx(() {
                                  return CustomTextField(
                                    isTitle: true,
                                    title: Strings.cardHolderName,
                                    hintText: Strings.inputName,
                                    textInputAction: TextInputAction.next,
                                    inputType: TextInputType.name,
                                    textCapitalization: TextCapitalization.words,
                                    controller: controller.cardHolderNameController,
                                    isError: controller.cardHolderNameError.value,
                                    hintColor: controller.cardHolderNameError.value ? AppColors.errorColor : AppColors.lightTextColor,
                                    color: controller.cardHolderNameError.value ? AppColors.errorColor : AppColors.darkTextColor,
                                  );
                                }),
                                SizedBox(height: 1.6.h),
                                Obx(() {
                                  return CustomTextField(
                                    isTitle: true,
                                    title: Strings.expirationDate,
                                    hintText: Strings.inputMMYY,
                                    textInputAction: TextInputAction.next,
                                    inputType: TextInputType.datetime,
                                    controller: controller.expirationDateController,
                                    isError: controller.expirationDateError.value,
                                    hintColor: controller.expirationDateError.value ? AppColors.errorColor : AppColors.lightTextColor,
                                    color: controller.expirationDateError.value ? AppColors.errorColor : AppColors.darkTextColor,
                                    inputFormat: [
                                      CreditCardExpirationDateFormatter(),
                                    ],
                                    onChange: (val) {
                                      if (val.isNotEmpty) {
                                        List<String> obj = val.split("/");
                                        if (obj.length == 1) {
                                          controller.expireMonth.value = obj[0];
                                        }
                                        if (obj.length == 2) {
                                          controller.expireMonth.value = obj[0];
                                          controller.expireyear.value = obj[1];
                                        }
                                      }
                                      controller.update();
                                    },
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
                                    title: Strings.cvv,
                                    hintText: Strings.inputCVV,
                                    textInputAction: TextInputAction.done,
                                    inputType: TextInputType.number,
                                    controller: controller.cvvController,
                                    isError: controller.cvvError.value,
                                    hintColor: controller.cvvError.value ? AppColors.errorColor : AppColors.lightTextColor,
                                    color: controller.cvvError.value ? AppColors.errorColor : AppColors.darkTextColor,
                                    onChange: (val) {
                                      if (val.isNotEmpty) {
                                        for (int i = 0; i < val.length; i++) {
                                          controller.cvvNumber.value = i + 1;
                                        }
                                      }
                                      controller.update();
                                    },
                                    inputFormat: [
                                      CreditCardCvcInputFormatter(),
                                    ],
                                    suffix: Image.asset(
                                      ImagePath.cardSmall,
                                      width: 3.h,
                                    ),
                                  );
                                }),
                                SizedBox(height: 1.8.h),
                              ],
                            )
                          : Container();
                    }),
                    Row(
                      children: [
                        Text(
                          Strings.setAsPrimaryPayment,
                          style: TextStyle(
                            color: AppColors.darkTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Obx(() {
                          return CupertinoSwitch(
                            value: controller.primaryPaymentSelectList[controller.primaryPaymentSelectNumber.value].value,
                            onChanged: (value) {
                              for (int i = 0; i < controller.paymentMethodList.length; i++) {
                                controller.primaryPaymentSelectList[i].value = false;
                              }
                              controller.primaryPaymentSelectList[controller.primaryPaymentSelectNumber.value].value = value;
                              if (controller.paymentMethodList[1].isSelected!.value) {
                                controller.saveCardDetailsResponseAPI(1);
                              } else if (controller.paymentMethodList[2].isSelected!.value) {
                                controller.saveCardDetailsResponseAPI(2);
                              }
                            },
                            thumbColor: CupertinoColors.white,
                            activeColor: AppColors.appColorText,
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 2.4.h),
                    Obx(() {
                      return controller.paymentMethodList[0].isSelected!.value
                          ? CustomButton(
                              onPressed: () {
                                if (controller.isValid()) {
                                  controller.saveCardDetailsResponseAPI(0);
                                }
                              },
                              text: Strings.addPayment,
                            )
                          : const SizedBox();
                    }),
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
                const CustomAppBar(
                  isBack: true,
                  title: Strings.addPayment,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
