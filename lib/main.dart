import 'package:beep_car_wash/api_repository/loading.dart';
import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/routes/app_pages.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    printError('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Loading();
    Utils.darkStatusBar();
    Utils.screenPortrait();
    Get.put(CommonController());
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: Constants.fontFamily,
            primarySwatch: AppColors.primerColor,
            primaryColor: AppColors.primerColor,
          ),
          builder: EasyLoading.init(),
          getPages: AppPages.list,
          home: const SplashScreen(),
        );
      },
    );
  }
}
