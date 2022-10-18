// import 'package:beep_car_wash/commons/app_colors.dart';
// import 'package:beep_car_wash/commons/common_widget.dart';
// import 'package:beep_car_wash/commons/strings.dart';
// import 'package:beep_car_wash/commons/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void alertActionDialog({
//   required BuildContext context,
//   String? massage,
//   String? rightBtnName,
//   String? leftBtnName,
//   GestureTapCallback? onRightClick,
// }) async {
//   Utils utils = Utils();
//   
//   utils.hideKeyboard(context);
//
//   showDialog(
//       context: context,
//       barrierColor: Colors.black26,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.transparent,
//               insetPadding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).moderateScale(30)),
//               elevation: 8,
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(ResponsiveFlutter.of(context).moderateScale(20)),
//                 decoration: BoxDecoration(
//                   color: AppColors.lightOrangeColor,
//                   borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).moderateScale(15)),
//                   border: Border.all(width: 1.5, color: AppColors.lightDarkBlueColor),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     MyTextView(
//                       Strings.appName,
//                       textStyleNew: MyTextStyle(
//                         textColor: AppColors.darkBlueColor,
//                         textSize: ResponsiveFlutter.of(context).fontSize(2.9),
//                         textWeight: FontWeight.w400,
//                         textFamily: Constants.klasik,
//                       ),
//                     ),
//                     SizedBox(height: ResponsiveFlutter.of(context).verticalScale(12)),
//                     MyTextView(
//                       massage ?? "",
//                       isMaxLineWrap: true,
//                       textAlignNew: TextAlign.center,
//                       textStyleNew: MyTextStyle(
//                         textColor: AppColors.darkBlueColor,
//                         textSize: ResponsiveFlutter.of(context).fontSize(2),
//                         textWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: ResponsiveFlutter.of(context).verticalScale(25)),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => Get.back(),
//                             child: commonButton(
//                               context: context,
//                               title: leftBtnName ?? Strings.no,
//                               smallButton: true,
//                               isBorder: true,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: ResponsiveFlutter.of(context).scale(20)),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: onRightClick,
//                             child: commonButton(
//                               context: context,
//                               title: rightBtnName ?? Strings.yes,
//                               smallButton: true,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       });
// }
//
// void messageDialog({
//   required BuildContext context,
//   String? massage,
//   String? btnName,
//   GestureTapCallback? onBtnClick,
// }) async {
//   Utils utils = Utils();
//   
//   utils.hideKeyboard(context);
//
//   showDialog(
//       context: context,
//       barrierColor: Colors.black26,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               backgroundColor: Colors.transparent,
//               insetPadding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).moderateScale(30)),
//               elevation: 8,
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(ResponsiveFlutter.of(context).moderateScale(20)),
//                 decoration: BoxDecoration(
//                   color: AppColors.lightOrangeColor,
//                   borderRadius: BorderRadius.circular(ResponsiveFlutter.of(context).moderateScale(15)),
//                   border: Border.all(width: 1.5, color: AppColors.lightDarkBlueColor),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     MyTextView(
//                       Strings.appName,
//                       textStyleNew: MyTextStyle(
//                         textColor: AppColors.darkBlueColor,
//                         textSize: ResponsiveFlutter.of(context).fontSize(2.9),
//                         textWeight: FontWeight.w400,
//                         textFamily: Constants.klasik,
//                       ),
//                     ),
//                     SizedBox(height: ResponsiveFlutter.of(context).verticalScale(12)),
//                     MyTextView(
//                       massage ?? "",
//                       isMaxLineWrap: true,
//                       textAlignNew: TextAlign.center,
//                       textStyleNew: MyTextStyle(
//                         textColor: AppColors.darkBlueColor,
//                         textSize: ResponsiveFlutter.of(context).fontSize(2),
//                         textWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: ResponsiveFlutter.of(context).verticalScale(25)),
//                     Row(
//                       children: [
//                         const Expanded(child: SizedBox()),
//                         Expanded(
//                           flex: 2,
//                           child: GestureDetector(
//                             onTap: onBtnClick ?? () => Get.back(),
//                             child: commonButton(
//                               context: context,
//                               title: btnName ?? Strings.ok,
//                               smallButton: true,
//                             ),
//                           ),
//                         ),
//                         const Expanded(child: SizedBox()),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       });
// }
