import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HowItWorkScreen extends GetView<HowItWorkController> {
  const HowItWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HowItWorkController>(
        init: HowItWorkController(),
        initState: (_) {
          controller.howItWorkAPI();
        },
        builder: (_) {
          return Stack(
            children: [
              controller.htmlViewModel != null
                  ? SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 3.h),
                      child: HtmlWidget(
                        controller.htmlViewModel!.pageContent!,
                        baseUrl: Uri.parse("http://machine.beepwash.com/"),
                      ),
                    )
                  : const SizedBox(),
              const CustomAppBar(
                title: Strings.howItWork,
              ),
            ],
          );
        });
  }
}
