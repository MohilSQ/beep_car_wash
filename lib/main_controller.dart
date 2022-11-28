import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/main.dart';
import 'package:beep_car_wash/notitication_provider/counter_bloc.dart';
import 'package:beep_car_wash/notitication_provider/counter_bloc_provider.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_binding.dart';
import 'package:beep_car_wash/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  GetStorageData getStorage = GetStorageData();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  CounterBloc? bloc;

  void iOSPermission() async {
    printOkStatus("<<<<<-------------- User granted permission -------------->>>>>");
    await firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
  }

  void tokenReceived(String pushToken) async {
    printOkStatus("Device Id ---------->>> $pushToken");
    getStorage.saveString(getStorage.deviceId, pushToken);
  }

  firebaseInit() async {
    iOSPermission();
    firebaseMessaging.getToken().then((value) => tokenReceived(value!));
    firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        printOkStatus("message -- main -- initState ---------->>> ${message.messageType}");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      printOkStatus("onMessage -------->>> ${message.data}");

      Constants.notificationCount = "${int.tryParse(Constants.notificationCount)! + 1}";
      bloc!.increment.add(null);
      printOkStatus("notificationCount -----------*--------->>> ${Constants.notificationCount}");
      FlutterAppBadger.updateBadgeCount(notyCount + 1);

      RemoteNotification? notification = message.notification;
      flutterLocalNotificationsPlugin!.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel!.id,
            channel!.name,
            channelDescription: channel!.description,
            icon: 'ic_notifications',
            channelShowBadge: true,
            enableLights: true,
            playSound: true,
          ),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      printOkStatus('A new onMessageOpenedApp event was published! - data ---------->>> ${message.data}');
      if (Get.find<CommonController>().userDataAvailableOrNot()) {
        Get.find<CommonController>().getUserData();
        Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
      } else {
        Get.offAll(() => const OnBoardingScreen(), binding: OnBoardingBindings());
      }
    });

    const InitializationSettings initializationSettings = InitializationSettings(android: AndroidInitializationSettings('ic_notifications'));

    firebaseMessaging.getInitialMessage();
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        printOkStatus('onDidReceiveNotificationResponse - details ---------->>> ${details.toString()}');
        if (Get.find<CommonController>().userDataAvailableOrNot()) {
          Get.find<CommonController>().getUserData();
          Get.offAll(() => const DrawerScreen(), binding: DrawerBindings());
        } else {
          Get.offAll(() => const OnBoardingScreen(), binding: OnBoardingBindings());
        }
      },
    );
  }

  @override
  void onInit() {
    bloc = CounterBlocProvider.of(Get.context!);
    firebaseInit();
    FlutterAppBadger.removeBadge();
    super.onInit();
  }
}
