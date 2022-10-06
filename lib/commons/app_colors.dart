import 'package:flutter/material.dart';

/// Enter your app primer color code in opacity ----->>
/// NOTE: Don't change opacity code just change color code -------->>
Map<int, Color> textColor = {
  50: const Color(0x1aFF9800),
  100: const Color(0x26FF9800),
  200: const Color(0x33FF9800),
  300: const Color(0x4dFF9800),
  400: const Color(0x66FF9800),
  500: const Color(0x80FF9800),
  600: const Color(0x99FF9800),
  700: const Color(0xb3FF9800),
  800: const Color(0xccFF9800),
  900: const Color(0xe6FF9800),
};

class AppColors {
  /// Enter your app primer color code ----->>
  static MaterialColor primerColor = MaterialColor(0x80FF9800, textColor);

  ///************** Common Color **************///
  /// NOTE: DO not remove this colors -------->>>
  Color blackColor = const Color(0xFF000000);
  Color whiteColor = const Color(0xFFFFFFFF);
  Color yellowColor = const Color(0xFFEEC829);
  Color redColor = const Color(0xFFE94057);
  Color blueColor = const Color(0xFF2196F3);
  Color greyColor = const Color(0xFF707070);
  Color lightGreyColor = const Color(0xFFE3E0E0);
  Color transparentColor = const Color(0x00000000);

  Color appColor = const Color(0xFFFF9800);

  ///************** Text Color **************///
  Color lightOrangeColor = const Color(0xFFFFF2E9);
  Color orangeColor = const Color(0xFFFF9800);
  Color darkBlueColor = const Color(0xFF263240);
  Color lightDarkBlueColor = const Color(0x80263240);
}
