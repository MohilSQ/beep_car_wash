import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../commons/app_colors.dart';
import '../../commons/strings.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'feedback_controller.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({Key? key}) : super(key: key);
  static const routeName = "/FeedbackScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
      builder: (logic) {
        return WillPopScope(
          onWillPop: () {
            Get.off(() => const DrawerScreen(), binding: DrawerBindings());
            return Future(() => false);
          },
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              top: false,
              child: Stack(
                children: [
                  const CustomAppBar(
                    title: "Feedback",
                    isButton: false,
                  ),
                  ListView(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 4.h,
                      right: 4.w,
                      left: 4.w,
                    ),
                    children: [
                      controller.rating.value != "5"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Give Feedback",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  "How did we do?",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blackColor,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "How was our service today?",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackColor,
                              ),
                            ),
                      SizedBox(height: 2.h),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        glowColor: Colors.amber,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          controller.rating.value = "${rating.toInt()}";
                          controller.getFeedbackRemarksAPI("${rating.toInt()}");
                        },
                      ),
                      SizedBox(height: 2.h),
                      controller.options.isEmpty
                          ? const SizedBox()
                          : ChipsChoice.multiple(
                              value: controller.list,
                              onChanged: (val) {
                                controller.list.value = val;
                                printAction("controller.list.value ----------->> ${controller.list}");
                                controller.update();
                              },
                              wrapped: true,
                              padding: EdgeInsets.zero,
                              choiceItems: C2Choice.listFrom<String, String>(
                                  source: controller.options,
                                  value: (i, v) {
                                    printAction("i ----------->> $i");
                                    return controller.optionsID[i].toString();
                                  },
                                  label: (i, v) {
                                    printAction("V ----------->> $v");
                                    return v;
                                  }),
                              choiceStyle: C2ChipStyle.toned(),
                            ),
                      SizedBox(height: 5.h),
                      controller.rating.value != "5"
                          ? CustomTextField(
                              isTitle: true,
                              isHight: false,
                              title: Strings.comment,
                              hintText: Strings.writeAComment,
                              textInputAction: TextInputAction.next,
                              inputType: TextInputType.multiline,
                              controller: controller.comment,
                              minLines: 5,
                              isMaxLines: true,
                              padding: EdgeInsets.all(1.8.h),
                            )
                          : Container(),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 2.h),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.h),
                          child: CustomButton(
                            onPressed: () {
                              controller.submitFeedbacksAPI();
                            },
                            text: "Done",
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).padding.bottom + 1.6.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
