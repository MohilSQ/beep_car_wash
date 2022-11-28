import 'package:beep_car_wash/api_repository/loading.dart';
import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/main_controller.dart';
import 'package:beep_car_wash/notitication_provider/counter_bloc_provider.dart';
import 'package:beep_car_wash/routes/app_pages.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/splash_screen/splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

int notyCount = 0;
List<CameraDescription> cameras = [];
AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  printOkStatus('Handling a background message -----1----->>>>>${message.data}');
  FlutterAppBadger.updateBadgeCount(notyCount + 1);
  printOkStatus('Handling a background message ------2---->>>>> ${message.messageId}');
}

Future<void> main() async {
  Get.put(CommonController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    printError('Error in fetching the cameras: $e');
  }

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      playSound: true,
      importance: Importance.high,
      showBadge: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel!);
  }

  runApp(CounterBlocProvider(child: const MyApp()));
}

class MyApp extends GetView<MainController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Loading();
    Utils.darkStatusBar();
    Utils.screenPortrait();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: Constants.navigatorKey,
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