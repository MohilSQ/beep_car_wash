import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/privacy_and_policy_screen/privacy_and_policy_controller.dart';
import 'package:beep_car_wash/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';

class PrivacyAndPolicyScreen extends GetView<PrivacyAndPolicyController> {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyAndPolicyController>(
        init: PrivacyAndPolicyController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              bottom: false,
              top: false,
              child: Stack(
                children: [
                  controller.htmlViewModel != null
                      ? SingleChildScrollView(
                          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w).copyWith(top: MediaQuery.of(context).padding.top + AppBar().preferredSize.height + 3.h),
                          child: HtmlWidget(
                            controller.htmlViewModel!.pageContent!,
                          ),
                        )
                      : const SizedBox(),
                  const CustomAppBar(
                    isBack: true,
                    title: Strings.privacyAndPolicy,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
