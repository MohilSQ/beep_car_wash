import 'dart:io';

import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/biling_screen/billing_binding.dart';
import 'package:beep_car_wash/screens/biling_screen/billing_screen.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../main.dart';

class CustomCameraController extends GetxController {
  CameraController? controller;
  bool isCameraInitialized = false;
  RxInt cameraSelected = 0.obs;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Initialize controller
    controller = cameraController;
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      printWarning('Error initializing camera: $e');
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      update();
    });

    isCameraInitialized = controller!.value.isInitialized;
    update();
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      printError('Error occurred while taking picture: $e');
      return null;
    }
  }

  /// ---- UploadMachine Photo API ------------>>>
  uploadMachinePhotoAPI(File image) async {
    FormData formData = FormData.fromMap({
      "token": Get.find<CommonController>().userDataModel.token,
      "wash_id": Get.arguments[1],
    });

    formData.files.addAll([
      MapEntry("machine_photo", MultipartFile.fromFileSync(image.path, filename: image.path.split("/").last)),
    ]);

    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.attachMachinePhoto,
      params: formData,
      isFormData: true,
    );

    if (data["code"] == 200) {
      Get.to(() => const BillingScreen(), binding: BillingBinding(), arguments: [Get.arguments[0], Get.arguments[1], Get.arguments[2]]);
    } else if (data["code"] == 201) {
      Utils().showSnackBar(context: Get.context!, message: data["msg"]);
    }
  }

  @override
  void onInit() {
    onNewCameraSelected(cameras[0]);
    super.onInit();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
