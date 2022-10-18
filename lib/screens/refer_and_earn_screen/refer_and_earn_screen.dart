import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ReferAndEarnScreen extends GetView<ReferAndEarnController> {
  const ReferAndEarnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          TabBarView(
            children: [
              referOperatorTab(),
              inviteFriendsTab(),
            ],
          ),
          CustomAppBar(
            title: "Referral",
            height: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 4.5.h,
            bottonChild: TabBar(
              labelStyle: MyTextStyle(
                textSize: 12.sp,
                textWeight: FontWeight.bold,
              ),
              unselectedLabelColor: AppColors.lightTextColor,
              labelColor: AppColors.appColorText,
              indicatorColor: AppColors.appColorText,
              tabs: const [
                Tab(text: "Refer Operator"),
                Tab(text: "Invite Friends"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget referOperatorTab() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 6.w).copyWith(top: MediaQuery.of(Get.context!).padding.top + AppBar().preferredSize.height + 3.6.h),
      children: [
        Image.asset(
          ImagePath.referOperatorImage,
          height: 50.w,
        ),
        SizedBox(height: 3.h),
        MyTextView(
          "Spread The Wealth",
          textStyleNew: MyTextStyle(
            textColor: AppColors.darkTextColor,
            textWeight: FontWeight.bold,
            textSize: 18.sp,
          ),
        ),
        SizedBox(height: 1.6.h),
        MyTextView(
          "Share your personal code with potential operators. After they get their first beep wash booking, you both earn a \$100 each!",
          isMaxLineWrap: true,
          textAlignNew: TextAlign.center,
          textStyleNew: MyTextStyle(
            textColor: AppColors.lightTextColor,
            textWeight: FontWeight.w600,
            textSize: 10.6.sp,
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "1",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "Invite operators by sharing your code",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "They sign up using your code below into the app",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.2.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "2",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "Set up their beep operation",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "Once they set up their beep operation and receive their first beep booking you both earn",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.2.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "3",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "You both earn \$100!",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "Your \$100 will be added to your earnings and be  available for withdrawal immediately",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.2.h),
        Align(
          alignment: Alignment.center,
          child: MyTextView(
            "Terms apply",
            textStyleNew: MyTextStyle(
              textColor: AppColors.appColorText,
              textWeight: FontWeight.bold,
              textSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 2.2.h),
        CustomButton(
          onPressed: () {},
          text: "Invite Friend",
        ),
        SizedBox(height: MediaQuery.of(Get.context!).padding.bottom),
      ],
    );
  }

  Widget inviteFriendsTab() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 6.w).copyWith(top: MediaQuery.of(Get.context!).padding.top + AppBar().preferredSize.height + 8.h),
      children: [
        Image.asset(
          ImagePath.inviteFriendsImage,
          width: 45.w,
          height: 45.w,
          fit: BoxFit.fitHeight,
        ),
        SizedBox(height: 3.h),
        MyTextView(
          "Spread The Wealth",
          textStyleNew: MyTextStyle(
            textColor: AppColors.darkTextColor,
            textWeight: FontWeight.bold,
            textSize: 18.sp,
          ),
        ),
        SizedBox(height: 1.6.h),
        MyTextView(
          "Share your personal code with your friends. After they get their first beep wash, you both earn a free wash",
          isMaxLineWrap: true,
          textAlignNew: TextAlign.center,
          textStyleNew: MyTextStyle(
            textColor: AppColors.lightTextColor,
            textWeight: FontWeight.w600,
            textSize: 10.6.sp,
          ),
        ),
        SizedBox(height: 3.2.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "1",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "Invite friends by sharing your code",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "They use your code below on their first wash",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "2",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "Both earn a free wash",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "You and your friend both enjoy a free beep wash on your next wash",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 4.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightAppColor,
              ),
              child: MyTextView(
                "3",
                textStyleNew: MyTextStyle(
                  textColor: AppColors.appColorText,
                  textWeight: FontWeight.bold,
                  textSize: 11.sp,
                ),
              ),
            ),
            SizedBox(width: 2.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextView(
                    "Enjoy Beep with your friends and love ones",
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.darkTextColor,
                      textWeight: FontWeight.bold,
                      textSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  MyTextView(
                    "The free wash will be automatically applied on your next wash",
                    isMaxLineWrap: true,
                    textAlignNew: TextAlign.start,
                    textStyleNew: MyTextStyle(
                      textColor: AppColors.lightTextColor,
                      textWeight: FontWeight.w600,
                      textSize: 10.6.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.2.h),
        Align(
          alignment: Alignment.center,
          child: MyTextView(
            "Terms apply",
            textStyleNew: MyTextStyle(
              textColor: AppColors.appColorText,
              textWeight: FontWeight.bold,
              textSize: 12.sp,
            ),
          ),
        ),
        SizedBox(height: 2.2.h),
        CustomButton(
          onPressed: () {},
          text: "Invite Friend",
        ),
        SizedBox(height: MediaQuery.of(Get.context!).padding.bottom),
      ],
    );
  }
}
