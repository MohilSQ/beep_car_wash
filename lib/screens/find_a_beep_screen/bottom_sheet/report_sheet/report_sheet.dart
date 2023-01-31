import 'dart:io';

import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/bottom_sheet/report_sheet/report_controller.dart';
import 'package:beep_car_wash/widgets/custom_button.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../scan_qr_code_screen/scan_qr_code_binding.dart';
import '../../../scan_qr_code_screen/scan_qr_code_screen.dart';

class ReportSheet extends GetView<ReportController> {
  final String machineId;

  const ReportSheet({super.key, required this.machineId});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportController());
    return GetBuilder<ReportController>(
      builder: (logic) {
        return Wrap(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.report,
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
                    Strings.whatIssueAreYouFacing,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.reportOptionModel.data?.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(height: 1.h),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        for (int i = 0; i < controller.reportOptionModel.data!.length; i++) {
                          if (index == i) {
                            controller.reportOptionModel.data![i].isSelected = true;
                            controller.issueId.value = controller.reportOptionModel.data?[i].id.toString() ?? "";
                          } else {
                            controller.reportOptionModel.data![i].isSelected = false;
                          }
                        }
                        controller.update();
                      },
                      child: Row(
                        children: [
                          Icon(
                            controller.reportOptionModel.data?[index].isSelected ?? false ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: AppColors.appColorText,
                            size: 3.h,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            controller.reportOptionModel.data?[index].issue ?? "",
                            style: TextStyle(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    Strings.attachPhoto,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.transparentColor,
                        builder: (context) => imageDialog(),
                      );
                    },
                    child: Container(
                      height: 6.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 1.8.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1.6.h),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            ImagePath.tablerPhoto,
                            height: 3.3.h,
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Text(
                              controller.image.value,
                              softWrap: false,
                              style: TextStyle(
                                color: AppColors.appColorText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            Strings.add,
                            style: TextStyle(
                              color: AppColors.appColorText,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    Strings.machineCode,
                    style: TextStyle(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.to(() => const ScanQRCodeScreen(), binding: ScanQRCodeBinding(), arguments: ["Report", machineId.toString()])?.then(
                        (value) {
                          if (value != null) {
                            controller.machineCode.value = value;
                            controller.update();
                          }
                        },
                      );
                    },
                    child: Container(
                      height: 6.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 1.8.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1.6.h),
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            controller.machineCode.value.isEmpty ? Strings.machineCode : controller.machineCode.value,
                            style: TextStyle(
                              color: AppColors.appColorText,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            Strings.scan,
                            style: TextStyle(
                              color: AppColors.appColorText,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  CustomTextField(
                    isTitle: true,
                    isHight: false,
                    title: Strings.writeAComment,
                    hintText: Strings.inputText,
                    textInputAction: TextInputAction.next,
                    inputType: TextInputType.number,
                    controller: TextEditingController(),
                    minLines: 5,
                    isMaxLines: true,
                    padding: EdgeInsets.all(1.8.h),
                    // isError: controller.phoneNumberError.value,
                    // hintColor: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.lightTextColor,
                    // color: controller.phoneNumberError.value ? AppColors.errorColor : AppColors.darkTextColor,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            Get.back();
                          },
                          elevation: 0,
                          backgroundColor: AppColors.transparentColor,
                          text: Strings.cancel,
                          color: AppColors.appColorText,
                          borderSide: BorderSide(
                            width: 0.1.h,
                            color: AppColors.lightGreyColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            if (controller.issueId.value.isEmpty) {
                              controller.utils.showSnackBar(message: Strings.vWhatIsIssue, context: context);
                            } else if (controller.image.value.isEmpty) {
                              controller.utils.showSnackBar(message: Strings.vAttachPhoto, context: context);
                            } else if (controller.machineCode.value.isEmpty) {
                              controller.utils.showSnackBar(message: Strings.vMachineCode, context: context);
                            } else if (controller.comment.text.isEmpty) {
                              controller.utils.showSnackBar(message: Strings.vComment, context: context);
                            } else {
                              controller.submitReportAPI(machineId);
                            }
                            // Get.back();
                          },
                          elevation: 0,
                          text: Strings.submit,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget imageDialog() {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(3.h), topRight: Radius.circular(3.h)),
          ),
          child: Column(
            children: [
              SizedBox(height: 1.8.h),
              Container(
                height: 0.6.h,
                width: 10.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  color: AppColors.grayBorderColor,
                ),
              ),
              SizedBox(height: 1.4.h),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.back();
                  controller.setProfileImage(ImageSource.gallery);
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: AppColors.transparentColor,
                text: Strings.selectAPhoto,
                icon: Platform.isAndroid ? Icons.image : CupertinoIcons.photo_on_rectangle,
                iconColor: AppColors.lightTextColor,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: TextStyle(
                  color: AppColors.lightTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              CustomButton(
                onPressed: () {
                  Get.back();
                  controller.setProfileImage(ImageSource.camera);
                },
                elevation: 0,
                borderRadius: 0,
                backgroundColor: AppColors.transparentColor,
                text: Strings.takeAPicture,
                icon: Platform.isAndroid ? Icons.camera_alt : CupertinoIcons.camera,
                iconColor: AppColors.lightTextColor,
                widgetSpace: 1.5.h,
                widgetMainAxis: MainAxisAlignment.start,
                horizontalPadding: 3.w,
                style: TextStyle(
                  color: AppColors.lightTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              Divider(height: 0.8.h),
              SizedBox(height: MediaQuery.of(Get.context!).padding.bottom + 1.6.h),
            ],
          ),
        ),
      ],
    );
  }
}
