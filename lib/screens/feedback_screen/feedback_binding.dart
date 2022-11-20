import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'feedback_controller.dart';

class FeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FeedbackController>(FeedbackController());
  }
}
