import 'dart:ui' as ui;

import 'package:beep_car_wash/commons/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../commons/image_path.dart';

class BillingController extends GetxController {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  TextEditingController code = TextEditingController();
  Utils utils = Utils();

  setMarker() async {
    Uint8List markerIcon = await getBytesFromAssets(ImagePath.marker, 160);
    final Marker marker = Marker(
      markerId: const MarkerId("1"),
      position: const LatLng(40.7127753, -74.0059728),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );

    markers[const MarkerId("1")] = marker;
    update();
  }

  @override
  void onInit() {
    setMarker();
    super.onInit();
  }

  /// ---- Converted Image To Marker Icon ------------>>>
  getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
