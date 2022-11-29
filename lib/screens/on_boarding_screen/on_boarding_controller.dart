
import 'dart:convert';
import 'dart:io';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class OnBoardingController extends GetxController {
  // String deviceId = "fgFKyqH6S0a2RcjCy4GQ6A:APA91bFuek6bjuVbWz3CiVTMLA-kmX8UpvOSEWalt2eqyu1Ks1AA9EFBVoYjMOc51Fv-AHFDaQVBfUknX4IaPRy0I6Wwlc2X73uY97xHDgTvP-RmVsW9EMtXQWXgzHQ6Bl4BG-ZXp9Ql";
  //
  // /// Send Push Notification
  // void sendPush(String message) async {
  //   String device = Platform.isAndroid ? "notification" : "data";
  //
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
