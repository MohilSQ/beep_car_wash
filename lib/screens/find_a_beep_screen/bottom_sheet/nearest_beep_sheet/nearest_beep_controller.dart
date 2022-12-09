import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class NearestBeepController extends GetxController {
  RxInt isExpand = 0.obs;
  Rx<CountDownController> countDownController = CountDownController().obs;

  List<CommonModel> actionList = [
    CommonModel(index: 0, image: ImagePath.navigation, title: Strings.navigation),
    CommonModel(index: 1, image: ImagePath.qrScan, title: Strings.scanToStart),
    CommonModel(index: 2, image: ImagePath.reserve, title: Strings.reserve),
    CommonModel(index: 3, image: ImagePath.report, title: Strings.report),
  ];

  List<CommonModel> machineData = [
    CommonModel(index: 0, image: ImagePath.droplet, title: "Spotless Water"),
    CommonModel(index: 1, image: ImagePath.bubble, title: "Triple Foam"),
    CommonModel(index: 2, image: ImagePath.wind, title: "Air Dryer"),
    CommonModel(index: 3, image: ImagePath.vaccum, title: "Vacuum Cleaner"),
  ];
}
