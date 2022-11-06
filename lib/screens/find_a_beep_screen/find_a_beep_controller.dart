import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindABeepController extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxBool mapView = false.obs;

  GoogleMapController? mapController;

  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  /// ---- User Registartion Api ------------>>>
  // userRegistartionAPI() async {
  //   var formData = ({
  //     "token": Get.arguments[2],
  //     "name": "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
  //     "email": emailController.text.trim(),
  //   });

  //   final data = await APIFunction().postApiCall(
  //     context: Get.context!,
  //     apiName: Constants.findNearestBeep,
  //     params: formData,
  //   );

  //   CommonTokenResponceModel model = CommonTokenResponceModel.fromJson(data);
  //   if (model.code == 200) {

  //     utils.showToast(context: Get.context!, message: model.msg!);
  //     storeUserData(model.token);
  //     Get.to(() => const DrawerScreen(), binding: DrawerBindings());
  //   } else if (model.code == 201) {
  //     utils.showSnackBar(context: Get.context!, message: model.msg!);
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 800), () {
      mapView.value = true;
    });
  }
}
