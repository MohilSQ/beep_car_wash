import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  GetStorageData getStorageData = GetStorageData();

  @override
  void onInit() {
    // TODO: implement onInit
    userDataAvailableOrNot();
    super.onInit();
  }

  userDataAvailableOrNot() {
    if (!getStorageData.containKey(getStorageData.isFirst)) {
      getStorageData.saveString(getStorageData.isFirst, "1");
    }
  }

  // String deviceId = "dhR-lG_HSVWEHeHkSBEKPU:APA91bEF-x9SGoJa1dlq2zaazPoQhfw02oxrjOIqHhftDbY32jQTY2DjgHnhdVuEleFlVQK6olIRzwMU1RnJaq2wBpnYIDGOSO1Y5vDCJCwNZKaYoBC11scDvy2pq1ySuqd2ZXXbGzuM";
  //
  // /// Send Push Notification
  // void sendPush(String message) async {
  //   http.Response response = await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: {
  //       "Content-Type": 'application/json',
  //       "Authorization": 'key=AAAAccFU3wE:APA91bFfBL9hWdWTZY2_3sxoSL3kHxn5T6oJAqm_gFXhHB3yvfN91uRzDR-WwAFP8LuloutD2XkX64ech8NTu3-mKAZTb4S7X-Pxn0xsiYQ4T1L3kxAezJnaB7V80a4o6gn9nE4xc7JY',
  //     },
  //     body: jsonEncode({
  //       "to": deviceId,
  //       "notification": {
  //         "body": message,
  //         "title": "New Message",
  //       },
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     printOkStatus("Response ------------>>> ${response.body}");
  //   } else {
  //     printError("Error ----------->>> ${response.body}");
  //   }
  // }
}
