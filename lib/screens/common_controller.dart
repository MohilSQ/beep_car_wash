import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/responce_model/user_data_model.dart';
import 'package:get/state_manager.dart';

class CommonController extends GetxController {
  GetStorageData getStorageData = GetStorageData();
  UserDataModel userDataModel = UserDataModel();

  bool userDataAvailableOrNot() {
    return getStorageData.containKey(getStorageData.loginData);
  }

  getUserData() {
    userDataModel = UserDataModel.fromJson(getStorageData.readObject(getStorageData.loginData));
    printOkStatus("User token -------------------->>> ${userDataModel.token!}");
  }
}
