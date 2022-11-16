import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DrawerScreen extends GetView<DrawerScreenController> {
  const DrawerScreen({Key? key}) : super(key: key);
  static const routeName = "/DrawerScreen";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (controller.screenNumber.value != 0) {
          for (int i = 0; i < controller.drawerList.length; i++) {
            controller.drawerList[i].isSelected!.value = false;
          }
          controller.drawerList[0].isSelected!.value = true;
          controller.drawerList[0].bindings!.dependencies();
          controller.screenNumber.value = 0;
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        key: Constants.scaffoldKey,
        drawer: Drawer(
          backgroundColor: AppColors.transparentColor,
          width: 78.6.w,
          elevation: 0,
          child: Stack(
            children: [
              Container(
                width: 74.w,
                color: AppColors.whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 6.w, top: MediaQuery.of(context).padding.top + 4.6.h),
                      child: Text(
                        "Hello, ${Get.find<CommonController>().userDataModel.firstName}",
                        style: TextStyle(
                          color: AppColors.appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.drawerList.length,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) => SizedBox(height: 0.8.h),
                        itemBuilder: (context, index) => Obx(() {
                          return CustomButton(
                            onPressed: () {
                              for (int i = 0; i < controller.drawerList.length; i++) {
                                if (i == index) {
                                  controller.drawerList[i].isSelected!.value = true;
                                  // controller.drawerList[index].bindings!.dependencies();
                                  controller.screenNumber.value = index;
                                  Constants.scaffoldKey.currentState!.closeDrawer();
                                } else {
                                  controller.drawerList[i].isSelected!.value = false;
                                }
                              }
                            },
                            elevation: 0,
                            borderRadius: 0,
                            backgroundColor: AppColors.transparentColor,
                            text: controller.drawerList[index].title,
                            color: index == 6
                                ? AppColors.appColorText
                                : controller.drawerList[index].isSelected!.value
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
                            image: controller.drawerList[index].image,
                            imageColor: index == 6
                                ? AppColors.appColorText
                                : controller.drawerList[index].isSelected!.value
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
                            widgetSpace: 1.5.h,
                            widgetMainAxis: MainAxisAlignment.start,
                            horizontalPadding: 1.4.h,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 78.6.w,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 4.6.h,
                    bottom: MediaQuery.of(context).padding.bottom + 2.2.h,
                    left: 6.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Constants.scaffoldKey.currentState!.closeDrawer();
                          },
                          child: CustomContainer(
                            height: 5.h,
                            width: 5.h,
                            circleView: true,
                            horizontalPadding: 2.h,
                            child: Image.asset(ImagePath.backArrow),
                          ),
                        ),
                      ),
                      CustomContainer(
                        isHeight: false,
                        borderRadius: 1.2.h,
                        containerColor: AppColors.appColorText,
                        padding: EdgeInsets.all(1.6.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    Strings.startMyCarWash,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(height: 0.4.h),
                                  Text(
                                    Strings.becomeAnOperatorAndEarnPassiveIncome,
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8.6.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 0.8.h),
                            Image.asset(
                              ImagePath.dollarSign,
                              height: 3.h,
                              color: AppColors.lightGreyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Obx(() {
          return SafeArea(
            bottom: false,
            top: false,
            child: controller.drawerList[controller.screenNumber.value].screen!,
          );
        }),
      ),
    );
  }
}
