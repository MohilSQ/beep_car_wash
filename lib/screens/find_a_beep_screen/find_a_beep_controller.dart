import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindABeepController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxBool mapView = false.obs;

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;

  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  setCameraPositin() async {
    cameraPosition = const CameraPosition(target: LatLng(40.7127753, -74.0059728), zoom: 18);
  }

  @override
  void onInit() {
    setCameraPositin();
    super.onInit();
  }
}
