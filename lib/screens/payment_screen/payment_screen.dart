import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_binding.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_screen.dart';
import 'package:beep_car_wash/screens/edit_payment_screen/edit_payment_binding.dart';
import 'package:beep_car_wash/screens/edit_payment_screen/edit_payment_screen.dart';
import 'package:beep_car_wash/screens/payment_screen/payment_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();
    return Column(
      children: [
        SizedBox(
          height: 56.h,
          child: Stack(
            children: [
              Image.asset(
                ImagePath.paymentsBG,
                height: 56.h,
                width: 100.w,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
              Column(
                children: [
                  CustomAppBar(
                    title: Strings.payment,
                    shadowVisible: false,
                    appBarColor: appColors.transparentColor,
                    textColor: appColors.whiteColor,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const EditPaymentScreen(), binding: EditPaymentBindings());
                        },
                        child: Image.asset(
                          ImagePath.icEdit,
                          height: 4.w,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  MyTextView(
                    "US \$ 0.00",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.whiteColor,
                      textWeight: FontWeight.bold,
                      textSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "Current Balance",
                    textStyleNew: MyTextStyle(
                      textColor: appColors.whiteColor,
                      textWeight: FontWeight.bold,
                      textSize: 9.sp,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    ImagePath.dummyImage3,
                    width: 80.w,
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 2,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemBuilder: (context, index) => SizedBox(
              height: 10.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  children: [
                    Image.asset(
                      ImagePath.masterCard,
                      width: 6.6.h,
                    ),
                    SizedBox(width: 2.h),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyTextView(
                            "Mastercard",
                            textStyleNew: MyTextStyle(
                              textColor: appColors.darkTextColor,
                              textWeight: FontWeight.bold,
                              textSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 0.6.h),
                          MyTextView(
                            "**** **** **** 5678",
                            textStyleNew: MyTextStyle(
                              textColor: appColors.lightTextColor,
                              textWeight: FontWeight.w600,
                              textSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    index == 0
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.6.h),
                            decoration: BoxDecoration(
                              color: appColors.lightBlueColor,
                              borderRadius: BorderRadius.circular(0.8.h),
                            ),
                            child: MyTextView(
                              "Primary",
                              textStyleNew: MyTextStyle(
                                textColor: appColors.blueText,
                                textWeight: FontWeight.bold,
                                textSize: 10.sp,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
        CustomButton(
          onPressed: () {
            Get.to(() => const AddPaymentScreen(), binding: AddPaymentBindings());
          },
          text: "Add New Payment",
          horizontalPadding: 6.w,
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
      ],
    );
  }
}
