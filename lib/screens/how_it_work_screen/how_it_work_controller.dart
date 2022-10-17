import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:get/get.dart';

class HowItWorkController extends GetxController {
  RxList<CommonModel> howItWorkList = <CommonModel>[
    CommonModel(title: "Process of scannig the machine", image: ImagePath.howItWork1),
    CommonModel(title: "Using the water function", image: ImagePath.howItWork2),
    CommonModel(title: "Using the foam function", image: ImagePath.howItWork3),
    CommonModel(title: "Using the blow dry the car function", image: ImagePath.howItWork4),
    CommonModel(title: "Using the vacuum function", image: ImagePath.howItWork5),
    CommonModel(title: "Using the hand wash function", image: ImagePath.howItWork6),
  ].obs;
}
