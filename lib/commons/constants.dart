// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constants {
  // Time Format .....
  static const String YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd hh:mm:ss';
  static const String YYYY_MM_DD_HH_MM_SS_24 = 'yyyy-MM-dd HH:mm:ss';
  static const String HH_MM_A = 'hh:mm a';

  // Font Name .....
  static const String appName = 'Beep';
  static const String fontFamily = 'NunitoSans';

  // Api credential .....
  static const String baseUrl = 'https://codewithwaqas.com/beep/api/';
  static const String profileImageUrl = 'https://codewithwaqas.com/beep/assets/avatars/';
  static const String phoneVerification = 'phone_verification';
  static const String otpVerification = 'otp_verification';
  static const String resendOTP = 'resend_otp';
  static const String userRegistration = 'user_registration';
  static const String saveSettings = 'save_settings';
  static const String uploadProfileImage = 'upload_profile_image';

  // About app .....
  static const String AboutUsLink = "";
  static const String PrivacyPolicyLink = "";
  static const String TermsAndConditionLink = "";

  // Global Variable .....
  static final scaffoldKey = GlobalKey<ScaffoldState>();
}
