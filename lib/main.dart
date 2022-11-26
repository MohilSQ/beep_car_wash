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


/*
 Navigator.of(context).push(
  MaterialPageRoute(
    builder: (BuildContext context) => UsePaypal(
      sandboxMode: false,
      clientId: "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
      secretKey: "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
      returnURL: "https://samplesite.com/return",
      cancelURL: "https://samplesite.com/cancel",
      transactions: const [
        {
          "amount": {
            "total": '10.12',
            "currency": "USD",
            "details": {
              "subtotal": '10.12',
              "shipping": '0',
              "shipping_discount": 20,
            }
          },
          "description": "The payment transaction description.",
          "item_list": {
            "items": [
              {
                "name": "Beep Car Wash",
                "price": '10.12',
                "currency": "USD",
              }
            ],
          }
        }
      ],
      note: "Contact us for any questions on your car wash.",
      onSuccess: (Map params) async {
        printOkStatus("onSuccess: $params");
      },
      onError: (error) {
        printError("onError: $error");
      },
      onCancel: (params) {
        printWarning('cancelled: $params');
      },
    ),
  ),
);
*/