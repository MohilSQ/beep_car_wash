import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:get/get.dart';

class NearestBeepController extends GetxController {
  List<CommonModel> actionList = [
    CommonModel(index: 0, image: ImagePath.navigation, title: Strings.navigation),
    CommonModel(index: 1, image: ImagePath.qrScan, title: Strings.scanToStart),
    CommonModel(index: 2, image: ImagePath.reserve, title: Strings.reserve),
    CommonModel(index: 3, image: ImagePath.report, title: Strings.report),
  ];
}
