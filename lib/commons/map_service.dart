import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapService {
  static Utils utils = Utils();
  static String? currentAddress;
  static String? currentCity;
  static Position? currentPosition;

  /// ---- Handle Location Permission --------------------- >>>
  static Future<bool> handleLocationPermission() async {
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
  static Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((Position position) {
      currentPosition = position;

      Constants.latitude = currentPosition!.latitude;
      Constants.longitude = currentPosition!.longitude;
      printOkStatus("currentPosition --------------->> Lat: ${Constants.latitude}, Long: ${Constants.longitude}");
      Get.find<FindABeepController>().mapView.value = true;
      Get.find<FindABeepController>().setMyLocationMarker();
      Get.find<FindABeepController>().getMachineAPI(Constants.getMachines);
    }).catchError((e) {
      printError(e);
    });
  }

  /// ---- TO Get Current Position --------------------- >>>
  static Future<void> getAddressFromLatLng(Position? currentPosition) async {
    await placemarkFromCoordinates(currentPosition!.latitude, currentPosition.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      printOkStatus("currentAddress --------------->> $placemarks");
    }).catchError((e) {
      printError(e);
    });
  }

  /// ---- TO Get Current City  --------------------- >>>
  static Future<void> getCityFromLatLng({double lat = 0.0, double log = 0.0}) async {
    await placemarkFromCoordinates(lat, log).then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      currentCity = place.locality;
    }).catchError((e) {
      printError(e);
    });
  }

  /// ---- TO Get Lat Lng From Address City  --------------------- >>>
  static Future<void> getLatLngFromAddress({String? address}) async {
    await locationFromAddress(address ?? "").then((List<Location> location) {
      Constants.latitude = location[0].latitude;
      Constants.longitude = location[0].longitude;
      printOkStatus("location --------------->> Lat: ${Constants.latitude}, Long: ${Constants.longitude}");
      Get.find<FindABeepController>().setMyLocationMarker();
      Get.find<FindABeepController>().getMachineAPI(Constants.findNearestBeep);
    }).catchError((e) {
      printError(e);
    });
  }
}
