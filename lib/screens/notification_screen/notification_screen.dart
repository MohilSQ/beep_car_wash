import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/common_widget.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        initState: (_) {
          controller.getNotificationAPI();
          controller.pagination();
        },
        builder: (_) {
          return Stack(
            children: [
              Column(
                children: [
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
                            controller: controller.scrollController,
                            itemCount: controller.notificationModel == null ? 0 : controller.notificationModel!.data!.length,
                            padding: EdgeInsets.symmetric(vertical: 2.h).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height),
                            separatorBuilder: (context, index) => SizedBox(height: 0.3.h),
                            itemBuilder: (context, index) {
                              var obj = controller.notificationModel!.data![index];
                              return Container(
                                color: /*index == 0 ? AppColors.lightAppColor :*/ AppColors.whiteColor,
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        MyTextView(
                                          obj.notifTitle ?? "",
                                          textStyleNew: MyTextStyle(
                                            textColor: /* index == 1 ? AppColors.darkTextColor : */ AppColors.appColorText,
                                            textWeight: FontWeight.bold,
                                            textSize: 12.sp,
                                          ),
                                        ),
                                        MyTextView(
                                          DateFormat.MMMEd().format(DateTime.parse(controller.utils.utcToLocal(obj.createdAt!))),
                                          textStyleNew: MyTextStyle(
                                            textColor: AppColors.lightTextColor,
                                            textWeight: FontWeight.bold,
                                            textSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    MyTextView(
                                      obj.notifBody,
                                      isMaxLineWrap: true,
                                      textAlignNew: TextAlign.start,
                                      textStyleNew: MyTextStyle(
                                        textColor: /*index == 1 ? AppColors.lightTextColor : */ AppColors.darkTextColor,
                                        textWeight: FontWeight.w600,
                                        textSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(1.2.h),
                                      child: CachedNetworkImage(
                                        imageUrl: "${controller.notificationModel!.notifUrl!}/${obj.image!}",
                                        height: 14.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        placeholder: (context, url) => Image.asset(ImagePath.notificationAvtar),
                                        errorWidget: (context, url, error) => Image.asset(ImagePath.notificationAvtar),
                                      ),
                                    ),
                                    SizedBox(height: 1.4.h),
                                  ],
                                ),
                              );
                            }),
                  ),
                  Obx(() => controller.isLoading.value
                      ? Padding(
                          padding: EdgeInsets.all(2.4.h).copyWith(bottom: MediaQuery.of(context).padding.bottom + 1.6.h),
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox()),
                ],
              ),
              const CustomAppBar(
                title: Strings.notification,
              ),
            ],
          );
        });
  }
}
