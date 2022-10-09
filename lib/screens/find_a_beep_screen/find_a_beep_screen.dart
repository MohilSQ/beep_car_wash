import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindABeepScreen extends GetView<FindABeepController> {
  const FindABeepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: true,
        child: Container(),
      ),
    );
  }
}
