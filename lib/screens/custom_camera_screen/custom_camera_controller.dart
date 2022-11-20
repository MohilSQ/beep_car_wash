import 'package:beep_car_wash/commons/utils.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

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

    controller = cameraController;

    // Update UI if controller updated
    cameraController.addListener(() {
      update();
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      printWarning('Error initializing camera: $e');
    }

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
