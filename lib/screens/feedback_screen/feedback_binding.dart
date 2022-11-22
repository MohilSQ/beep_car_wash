import 'package:get/get.dart';

import 'feedback_controller.dart';

class FeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FeedbackController>(FeedbackController());
  }
}
