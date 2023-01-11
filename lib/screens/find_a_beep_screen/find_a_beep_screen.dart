import 'package:beep_car_wash/commons/app_colors.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/image_path.dart';
import 'package:beep_car_wash/map_service/map_service.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/screens/find_a_beep_screen/find_a_beep_controller.dart';
import 'package:beep_car_wash/widgets/custom_container.dart';
import 'package:beep_car_wash/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:sizer/sizer.dart';

class FindABeepScreen extends GetView<FindABeepController> {
  const FindABeepScreen({Key? key}) : super(key: key);
  static const routeName = "/FindABeepScreen";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindABeepController>(
      init: FindABeepController(),
      initState: (state) {
        if (controller.mapController == null) {
          MapService.getCurrentPosition();
          controller.googlePlace = GooglePlace(Constants.mapKey);
        }
      },
      builder: (logic) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: controller.mapView.value
                      ? GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: false,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          myLocationButtonEnabled: false,
                          trafficEnabled: false,
                          initialCameraPosition: CameraPosition(target: LatLng(Constants.latitude, Constants.longitude), zoom: 16),
                          markers: Set<Marker>.of(controller.markers),
                          onMapCreated: (GoogleMapController googleMapController) async {
                            controller.mapController = googleMapController;
                            controller.mapController!.setMapStyle(await DefaultAssetBundle.of(context).loadString('assets/json_file/map_style.json'));
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w, right: 6.w, top: MediaQuery.of(context).padding.top + 1.5.h, bottom: 1.5.h),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Constants.scaffoldKey.currentState!.openDrawer();
                        },
                        child: CustomContainer(
                          height: 5.h,
                          width: 5.h,
                          circleView: true,
                          boxShadowVisible: true,
                          horizontalPadding: 1.4.h,
                          child: Image.asset(ImagePath.drawer),
                        ),
                      ),
                      Image.asset(
                        ImagePath.appNameImageShadow,
                        width: 11.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.mapController?.animateCamera(CameraUpdate.newLatLngZoom(LatLng(Constants.latitude, Constants.longitude), 16));
                        },
                        child: CustomContainer(
                          height: 5.h,
                          width: 5.h,
                          circleView: true,
                          boxShadowVisible: true,
                          horizontalPadding: 1.2.h,
                          child: Image.asset(ImagePath.location),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Column(
                    children: [
                      CustomContainer(
                        isHeight: false,
                        boxShadowVisible: true,
                        borderRadius: 1.h,
                        padding: EdgeInsets.only(left: 1.6.h, top: 0.8.h, bottom: 0.8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.setALocation,
                              style: TextStyle(
                                color: AppColors.appColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 8.6.sp,
                              ),
                            ),
                            SizedBox(height: 0.6.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  size: 2.8.h,
                                  color: AppColors.appColor,
                                ),
                                SizedBox(width: 0.8.h),
                                Expanded(
                                  child: CustomTextField(
                                    controller: controller.searchController,
                                    textInputAction: TextInputAction.done,
                                    hintText: Strings.yourLocation,
                                    fontSize: 10.sp,
                                    isDense: true,
                                    containerVisible: false,
                                    borderVisible: false,
                                    onChange: (value) {
                                      if (value.isEmpty) {
                                        controller.mapSearchView.value = false;
                                      } else {
                                        controller.mapSearchView.value = true;
                                        controller.autoCompleteSearch(value);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 1.8.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.4.h),
                      !controller.mapSearchView.value
                          ? const SizedBox()
                          : CustomContainer(
                              height: 34.h,
                              boxShadowVisible: true,
                              borderRadius: 1.h,
                              padding: EdgeInsets.zero,
                              child: controller.predictions.isEmpty
                                  ? const Text("No Result Found")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.predictions.length,
                                      padding: EdgeInsets.all(0.8.h),
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: AppColors.appColor,
                                            child: const Icon(
                                              Icons.pin_drop,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: Text(controller.predictions[index].description!),
                                          onTap: () {
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            controller.mapSearchView.value = false;
                                            controller.searchController.text = controller.predictions[index].description!;
                                            MapService.getLatLngFromAddress(address: controller.predictions[index].description!);
                                            controller.update();
                                          },
                                        );
                                      },
                                    ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
