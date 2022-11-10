import 'package:beep_car_wash/commons/app_colors.dart';
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
                    appBarColor: AppColors.transparentColor,
                    color: AppColors.whiteColor,
                  ),
                  const Spacer(),
                  Text(
                    "US \$ 0.00",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  Text(
                    Strings.currentBalance,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    ImagePath.paymentCard,
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
                padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(right: 1.w),
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
                          Text(
                            "Mastercard",
                            style: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 0.6.h),
                          Text(
                            "**** **** **** 5678",
                            style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    index == 0
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 0.8.h, vertical: 0.6.h),
                            decoration: BoxDecoration(
                              color: AppColors.lightBlueColor,
                              borderRadius: BorderRadius.circular(0.8.h),
                            ),
                            child: Text(
                              Strings.primary,
                              style: TextStyle(
                                color: AppColors.blueText,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 1, textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600), height: 3.4.h, child: const Text(Strings.primary)),
                        PopupMenuItem(value: 2, textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600), height: 3.4.h, child: const Text(Strings.edit)),
                        PopupMenuItem(value: 3, textStyle: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600), height: 3.4.h, child: const Text(Strings.delete)),
                      ],
                      offset: const Offset(-30, 40),
                      color: Colors.white,
                      icon: const Icon(Icons.more_vert_outlined),
                      onSelected: (data) {
                        if (data == 1) {
                        } else if (data == 2) {
                          Get.to(() => const EditPaymentScreen(), binding: EditPaymentBindings());
                        } else if (data == 3) {}
                      },
                    ),
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
          text: Strings.addNewPayment,
          horizontalPadding: 6.w,
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
      ],
    );
  }
}
