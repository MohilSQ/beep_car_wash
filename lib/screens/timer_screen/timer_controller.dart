import 'dart:async';

import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/response_model/stop_machine_response_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/custom_camera_screen/custom_camera_binding.dart';
import 'package:beep_car_wash/screens/custom_camera_screen/custom_camera_screen.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  Utils utils = Utils();
  Rx<CountDownController> countDownController = CountDownController().obs;
  Stopwatch stopwatch = Stopwatch();

  Timer? timer;
  RxInt start = 0.obs;

  void startTimer({int? isFareFix}) {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (isFareFix == 0) {
        start.value++;
      } else {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      }
    });
    update();
  }

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

    StopMachineResponseModel model = StopMachineResponseModel.fromJson(data);
    if (model.code == 200) {
      countDownController.value.pause();
      Get.to(() => const CustomCameraScreen(), binding: CustomCameraBinding(), arguments: [data, washId, false]);
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }
}
