import 'dart:convert';

import 'package:get_storage/get_storage.dart';

/// <<< To store data in phone storage --------- >>>
class GetStorageData {
  String loginData = "LoginData";
  String deviceId = "deviceId";

  /// <<< To save object data --------- >>>
  saveObject(String key, value) {
    final box = GetStorage();
    String allData = jsonEncode(value);
    box.write(key, allData);
  }

  /// <<< To read object data --------- >>>
  readObject(String key) {
    final box = GetStorage();
    var result = box.read(key);
    return jsonDecode(result);
  }

  /// <<< To save string data --------- >>>
  saveString(String key, value) async {
    final box = GetStorage();
    return box.write(key, value);
  }

  /// <<< To read string data --------- >>>
  readString(String key) {
    final box = GetStorage();
    if (box.hasData(key)) {
      return box.read(key);
    } else {
      return null;
    }
  }

  /// <<< To remove data --------- >>>
  removeData(String key) async {
    final box = GetStorage();
    return box.remove(key);
  }

  /// <<< To Store Key data --------- >>>
  bool containKey(String key) {
    final box = GetStorage();
    return box.hasData(key);
  }


}
