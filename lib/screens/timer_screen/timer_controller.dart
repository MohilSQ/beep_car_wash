import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Utils utils = Utils();
  Rx<CountDownController> countDownController = CountDownController().obs;

  RxInt min = 0.obs;

  /// ---- Stop Machine API ------------>>>
  stopMachineAPI(String washId) async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
      "wash_id": washId,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.stopMachine,
      params: formData,
    );

    // ScanToStartResponseModel model = ScanToStartResponseModel.fromJson(data);
    if (data["code"] == 200) {
      Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
    } else if (data["code"] == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
