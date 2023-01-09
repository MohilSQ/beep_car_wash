import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/check_job_status_response_model.dart';
import 'package:beep_car_wash/model/responce_model/stop_machine_response_model.dart';
import 'package:beep_car_wash/screens/biling_screen/billing_binding.dart';
import 'package:beep_car_wash/screens/biling_screen/billing_screen.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/custom_camera_screen/custom_camera_binding.dart';
import 'package:beep_car_wash/screens/custom_camera_screen/custom_camera_screen.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_binding.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_binding.dart';
import 'package:beep_car_wash/screens/timer_screen/timer_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Utils utils = Utils();

  @override
  void onReady() {
    if (Get.find<CommonController>().userDataAvailableOrNot()) {
      Get.find<CommonController>().getUserData();
      checkJobStatusAPI();
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAll(() => const OnBoardingScreen(), binding: OnBoardingBindings()),
      );
    }
    // Future.delayed(const Duration(seconds: 3), () => pageNavigation());
    super.onReady();
  }

  void pageNavigation() {
    if (Get.find<CommonController>().userDataAvailableOrNot()) {
      Get.find<CommonController>().getUserData();
      Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
    } else {
      Get.offAll(() => const OnBoardingScreen(), binding: OnBoardingBindings());
    }
  }

  /// ---- Check Job Status API ------------>>>
  checkJobStatusAPI() async {
    var formData = ({
      "token": Get.find<CommonController>().userDataModel.token,
    });

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.checkJobStatus,
      params: formData,
      isLoading: false,
    );

    CheckJobStatusResponseModel model = CheckJobStatusResponseModel.fromJson(data);
    if (model.code == 200) {
      if (model.isProcess == 0) {
        Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
      } else if (model.isProcess == 1) {
        Get.to(() => const TimerScreen(), binding: TimerBinding(), arguments: [true, model.washId, model.totalTime, model.remainigTime]);
      } else if (model.isProcess == 2) {
        StopMachineResponseModel stopMachineResponseModel = StopMachineResponseModel(
          data: Data(
            address: model.address,
            amount: model.amount,
            machineLat: model.machineLat,
            machineLong: model.machineLong,
            paymentSourceType: model.paymentSourceType,
            washTime: model.washTime,
          ),
        );
        Get.to(() => const CustomCameraScreen(), binding: CustomCameraBinding(), arguments: [stopMachineResponseModel, model.washId, true]);
      } else if (model.isProcess == 3) {
        StopMachineResponseModel stopMachineResponseModel = StopMachineResponseModel(
          data: Data(
            address: model.address,
            amount: model.amount,
            machineLat: model.machineLat,
            machineLong: model.machineLong,
            paymentSourceType: model.paymentSourceType,
            washTime: model.washTime,
          ),
        );
        Get.to(() => const BillingScreen(), binding: BillingBinding(), arguments: [stopMachineResponseModel, model.washId, true]);
      }
    } else if (model.code == 201) {
      Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
    }
  }
}
