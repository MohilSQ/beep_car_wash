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
  static const String baseUrl = 'http://machine.beepwash.com/api/';
  static const String profileImageUrl = 'http://machine.beepwash.com/assets/avatars/';
  static const String phoneVerification = 'phone_verification';
  static const String otpVerification = 'otp_verification';
  static const String resendOTP = 'resend_otp';
  static const String userRegistration = 'user_registration';
  static const String saveSettings = 'save_settings';
  static const String uploadProfileImage = 'upload_profile_image';
  static const String privacyPolicy = 'privacy_policy';
  static const String termsAndConditions = 'terms_and_conditions';
  static const String howItWorks = 'how_it_works';
  static const String getNotifications = 'get_notifications';
  static const String getWashHistory = 'get_wash_history';
  static const String getPaymentCardList = 'get_payment_sources';
  static const String updatePaymentSource = 'update_payment_source';
  static const String deletePaymentSource = 'delete_payment_source';
  static const String savePaymentCardList = 'save_payment_source';
  static const String getMachines = 'get_machines';
  static const String findNearestBeep = 'find_nearest_beep';
  static const String getReserveDetails = 'get_reserve_details';
  static const String reserveNow = 'reserve_now';
  static const String notifyMe = 'notify_me';
  static const String scanToStart = 'scan_to_start';
  static const String scanToReport = 'scan_report_qr';
  static const String stopMachine = 'stop_machine';
  static const String getReportOptions = 'get_report_options';
  static const String submitReport = 'submit_report';
  static const String getFeedbackRemarks = 'get_feedback_remarks';
  static const String submitFeedback = 'submit_feedback';
  static const String attachMachinePhoto = 'attach_machine_photo';
  static const String verifyCouponCode = 'verify_coupon_code';
  static const String saveCardPayment = 'save_card_payment';
  static const String saveOtherMethodPayment = 'save_other_method_payment';
  static const String socialLogin = 'social_login';
  static const String checkJobStatus = 'check_job_status';

  // Location And Map .....
  static double latitude = 0.0;
  static double longitude = 0.0;
  static String mapKey = "AIzaSyBXOkSkbXFoeyRXlZmmqBzxb9eGYY75LOE";

  // Global Variable .....
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey firstShowCase = GlobalKey();
  static final GlobalKey secondShowCase = GlobalKey();
  static final GlobalKey thirdShowCase = GlobalKey();
  static final GlobalKey fourthShowCase = GlobalKey();

  // Notification Count .....
  static String notificationCount = '0';
}
