import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_binding.dart';
import 'package:beep_car_wash/screens/add_payment_screen/add_payment_screen.dart';
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
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      initState: (_) {
        controller.getCardDetailsResponseAPI();
      },
      builder: (logic) {
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
                      Obx(() {
                        return Text(
                          Strings.us + controller.currentBalance!.value,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        );
                      }),
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
                      SizedBox(
                        width: 80.w,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(
                              ImagePath.paymentCard,
                              width: 80.w,
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.2.h).copyWith(left: 9.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "**** **** **** ${controller.cardLastNumber!.value}",
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(height: 0.6.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  Strings.expiresEnd,
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 5.sp,
                                                  ),
                                                ),
                                                Text(
                                                  "**/**",
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                              ],
                                            ),
                                            SizedBox(height: 1.h),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "******* **********",
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                        controller.getCardImage(controller.cardBrand!.value),
                                        width: controller.getCardImage(controller.cardBrand!.value) == ImagePath.creditCard ? 10.w : 15.w,
                                        height: 9.w,
                                        color: controller.getCardImage(controller.cardBrand!.value) == ImagePath.creditCard ? AppColors.whiteColor : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.noData!.value.isNotEmpty
                  ? Center(
                      child: Text(
                        controller.noData!.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.getPaymentDetailsModel == null ? 0 : controller.getPaymentDetailsModel!.data?.length ?? 0,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => const Divider(height: 0),
                      itemBuilder: (context, index) {
                        var obj = controller.getPaymentDetailsModel!.data![index];
                        return SizedBox(
                          height: 10.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(right: 1.w),
                            child: Row(
                              children: [
                                Image.asset(
                                  controller.getCardImage(obj.brand!.isEmpty ? obj.sourceType! : obj.brand!),
                                  width: 6.6.h,
                                  height: 5.h,
                                ),
                                SizedBox(width: 2.h),
                                Expanded(
                                  child: obj.brand!.isEmpty
                                      ? Text(
                                          obj.sourceType ?? "",
                                          style: TextStyle(
                                            color: AppColors.darkTextColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              obj.brand ?? "",
                                              style: TextStyle(
                                                color: AppColors.darkTextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            SizedBox(height: 0.6.h),
                                            Text(
                                              "**** **** **** ${obj.last4}",
                                              style: TextStyle(
                                                color: AppColors.lightTextColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                obj.primaryCard == "1"
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
                                    PopupMenuItem(
                                      value: 1,
                                      textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      height: 3.4.h,
                                      child: const Text(Strings.primary),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      height: 3.4.h,
                                      child: const Text(Strings.delete),
                                    ),
                                  ],
                                  offset: const Offset(-30, 40),
                                  color: Colors.white,
                                  icon: const Icon(Icons.more_vert_outlined),
                                  onSelected: (data) {
                                    if (data == 1) {
                                      controller.setPrimaryResponseAPI(index: index, id: int.parse(obj.id ?? ""));
                                    } else if (data == 2) {
                                      controller.deletePaymentResponseAPI(index: index, id: int.parse(obj.id ?? ""));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            CustomButton(
              onPressed: () {
                Get.to(() => const AddPaymentScreen(), binding: AddPaymentBindings())!.then((value) => controller.getCardDetailsResponseAPI());
              },
              text: Strings.addNewPayment,
              horizontalPadding: 6.w,
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
          ],
        );
      },
    );
  }
}
