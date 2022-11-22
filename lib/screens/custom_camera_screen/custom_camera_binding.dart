import 'package:get/get.dart';

import 'custom_camera_controller.dart';

class CustomCameraBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CustomCameraController>(CustomCameraController());
  }
}
