import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:beep_car_wash/screens/common_controller.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_binding.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_screen.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_bindings.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_screen.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_bindings.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_screen.dart';
import 'package:beep_car_wash/screens/payment_screen/payment_bindings.dart';
import 'package:beep_car_wash/screens/payment_screen/payment_screen.dart';
import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_bindings.dart';
import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_screen.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_bindings.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_screen.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_bindings.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DrawerScreenController extends GetxController {
  Utils utils = Utils();

  RxInt screenNumber = 0.obs;
  RxList<CommonModel> drawerList = <CommonModel>[
    CommonModel(title: Strings.findABeep, image: ImagePath.findABeep, isSelected: true.obs, screen: const FindABeepScreen(), bindings: FindABeepBindings()),
    CommonModel(title: Strings.washHistory, image: ImagePath.washHistory, isSelected: false.obs, screen: const WashHistoryScreen(), bindings: WashHistoryBindings()),
    CommonModel(title: Strings.payment, image: ImagePath.payment, isSelected: false.obs, screen: const PaymentScreen(), bindings: PaymentBindings()),
    CommonModel(title: Strings.notification, image: ImagePath.notification, isSelected: false.obs, screen: const NotificationScreen(), bindings: NotificationBindings()),
    CommonModel(title: Strings.howItWork, image: ImagePath.howItWork, isSelected: false.obs, screen: const HowItWorkScreen(), bindings: HowItWorkBindings()),
    CommonModel(title: Strings.setting, image: ImagePath.setting, isSelected: false.obs, screen: const SettingsScreen(), bindings: SettingsBindings()),
    CommonModel(title: Strings.referAndEarn, image: ImagePath.referAndEarn, isSelected: false.obs, screen: const ReferAndEarnScreen(), bindings: ReferAndEarnBindings()),
  ].obs;

  String? currentAddress;
  Position? currentPosition;

  /// ---- Handle Location Permission --------------------- >>>
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      utils.showToast(context: Get.context!, message: 'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        utils.showToast(context: Get.context!, message: 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      utils.showToast(context: Get.context!, message: 'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  /// ---- TO Get Current Position --------------------- >>>
  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      currentPosition = position;

      Constants.latitude = currentPosition!.latitude;
      Constants.longitude = currentPosition!.longitude;
      printOkStatus("currentPosition --------------->> Lat: ${Constants.latitude}, Long: ${Constants.longitude}");
      update();
      getAddressFromLatLng();
    }).catchError((e) {
      printError(e);
    });
  }

  /// ---- TO Get Current Position --------------------- >>>
  Future<void> getAddressFromLatLng() async {
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      printOkStatus("currentAddress --------------->> $placemarks");
    }).catchError((e) {
      printError(e);
    });
  }

  @override
  void onInit() {
    getCurrentPosition();
    drawerList[0].bindings!.dependencies();
    if (Get.find<CommonController>().userDataAvilabeOrNot()) {
      Get.find<CommonController>().getUserData();
    }
    super.onInit();
  }
}
