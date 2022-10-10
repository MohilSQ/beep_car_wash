import 'package:beep_car_wash/screens/notification_screen/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<NotificationController>(NotificationController());
  }
}
