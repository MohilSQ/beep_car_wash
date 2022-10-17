import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/model/common_model.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_binding.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_screen.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_bindings.dart';
import 'package:beep_car_wash/screens/how_it_work_screen/how_it_work_screen.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_bindings.dart';
import 'package:beep_car_wash/screens/notification_screen/notification_screen.dart';
import 'package:beep_car_wash/screens/payment_screen/payment_bindings.dart';
import 'package:beep_car_wash/screens/payment_screen/payment_screen.dart';
import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_bindings.dart';
import 'package:beep_car_wash/screens/refer_and_earn_screen/refer_and_earn_screen.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_bindings.dart';
import 'package:beep_car_wash/screens/settings_screen/settings_screen.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_bindings.dart';
import 'package:beep_car_wash/screens/wash_history_screen/wash_history_screen.dart';
import 'package:get/get.dart';

class DrawerScreenController extends GetxController {
  RxInt screenNumber = 0.obs;
  RxList<CommonModel> drawerList = <CommonModel>[
    CommonModel(title: Strings.findABeep, image: ImagePath.findABeep, isSelected: true.obs, screen: const FindABeepScreen(), bindings: FindABeepBindings()),
    CommonModel(title: Strings.washHistory, image: ImagePath.washHistory, isSelected: false.obs, screen: const WashHistoryScreen(), bindings: WashHistoryBindings()),
    CommonModel(title: Strings.payment, image: ImagePath.payment, isSelected: false.obs, screen: const PaymentScreen(), bindings: PaymentBindings()),
    CommonModel(title: Strings.notification, image: ImagePath.notification, isSelected: false.obs, screen: const NotificationScreen(), bindings: NotificationBindings()),
    CommonModel(title: Strings.howItWork, image: ImagePath.howItWork, isSelected: false.obs, screen: const HowItWorkScreen(), bindings: HowItWorkBindings()),
    CommonModel(title: Strings.setting, image: ImagePath.setting, isSelected: false.obs, screen: const SettingsScreen(), bindings: SettingsBindings()),
    CommonModel(title: Strings.referAndEarn, image: ImagePath.referAndEarn, isSelected: false.obs, screen: const ReferAndEarnScreen(), bindings: ReferAndEarnBindings()),
  ].obs;

  Future onWillPop() async {}

  @override
  void onInit() {
    drawerList[0].bindings!.dependencies();
    super.onInit();
  }
}
