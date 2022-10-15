import 'package:beep_car_wash/model/common_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ReportController extends GetxController{
  List<CommonModel> reportList = [
    CommonModel(isSelected: true.obs, title: "Water/Foam pump"),
    CommonModel(isSelected: false.obs, title: "Air Blower"),
    CommonModel(isSelected: false.obs, title: "Vaccum"),
    CommonModel(isSelected: false.obs, title: "Machine won’t turn on"),
    CommonModel(isSelected: false.obs, title: "Other Issue"),
  ];
}