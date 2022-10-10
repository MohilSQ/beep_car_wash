import 'package:beep_car_wash/screens/wash_history_screen/wash_history_controller.dart';
import 'package:get/get.dart';

class WashHistoryBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<WashHistoryController>(WashHistoryController());
  }
}
