import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_controller.dart';
import 'package:get/get.dart';

class HowItWorkBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<HowItWorkController>(HowItWorkController());
  }
}
