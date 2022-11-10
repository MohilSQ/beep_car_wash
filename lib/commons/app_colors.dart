import 'package:flutter/material.dart';

/// Enter your app primer color code in opacity ----->>
/// NOTE: Don't change opacity code just change color code -------->>
Map<int, Color> color = {
  50: const Color(0x1a00DD8D),
  100: const Color(0x2600DD8D),
  200: const Color(0x3300DD8D),
  300: const Color(0x4d00DD8D),
  400: const Color(0x6600DD8D),
  500: const Color(0x8000DD8D),
  600: const Color(0x9900DD8D),
  700: const Color(0xb300DD8D),
  800: const Color(0xcc00DD8D),
  900: const Color(0xe600DD8D),
};

class AppColors {
  /// Enter your app primer color code ----->>
  static MaterialColor primerColor = MaterialColor(0xFF00DD8D, color);

  ///************** Common Color **************///
  /// NOTE: DO not remove this colors -------->>>
  static Color blackColor = const Color(0xFF000000);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color yellowColor = const Color(0xFFEEC829);
  static Color redColor = const Color(0xFFE94057);
  static Color blueColor = const Color(0xFF2196F3);
  static Color greyColor = const Color(0xFF707070);
  static Color lightGreyColor = const Color(0xFFE3E0E0);
  static Color transparentColor = const Color(0x00000000);

  static Color appColor = const Color(0xFF00DD8D);
  static Color lightAppColor = const Color(0xFFDFF1EA);
  static Color darkAppColor = const Color(0xFF025839);

  ///************** Text Color **************///
  static Color darkTextColor = const Color(0xFF212121);
  static Color lightTextColor = const Color(0xFF898989);
  static Color appColorText = const Color(0xFF00AB6C);
  static Color blueText = const Color(0xFF0997B8);

  ///************** button Color **************///
  static Color buttonColor = const Color(0xFF00AB6C);
  static Color borderColor = const Color(0xFFEAEAEA);
  static Color grayBorderColor = const Color(0xFFD9D9D9);
  static Color errorColor = const Color(0xFFDE2800);
  static Color lightBlueColor = const Color(0xFFDFF3F8);
}
