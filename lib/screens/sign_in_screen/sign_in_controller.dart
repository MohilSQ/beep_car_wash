import 'dart:io';

import 'package:beep_car_wash/api_repository/api_function.dart';
import 'package:beep_car_wash/commons/constants.dart';
import 'package:beep_car_wash/commons/get_storage_data.dart';
import 'package:beep_car_wash/commons/strings.dart';
import 'package:beep_car_wash/commons/utils.dart';
import 'package:beep_car_wash/model/response_model/common_token_response_model.dart';
import 'package:beep_car_wash/model/response_model/otp_verification_response_model.dart';
import 'package:beep_car_wash/model/response_model/user_data_model.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_binding.dart';
import 'package:beep_car_wash/screens/drawer_screen/drawer_screen.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_binding.dart';
import 'package:beep_car_wash/screens/sign_in_otp_screen/sign_in_otp_screen.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';

class SignInController extends GetxController {
  Utils utils = Utils();
  GetStorageData getStorage = GetStorageData();

  Country? selectedCountry;
  TextEditingController phoneNumberController = TextEditingController();
  RxBool? phoneNumberError = false.obs;

  RxBool? isLoading = false.obs;

  String id = "";
  String email = "";
  String name = "";
  String photoUrl = "";
  String mediaName = "";

  UserDataModel userDataModel = UserDataModel();

  @override
  void onInit() {
    initCountry();
    successGoogle();
    super.onInit();
  }

  /// ---- Show Defult Country ------------>>>
  void initCountry() async {
    final country = await getDefaultCountry(Get.context!);
    selectedCountry = country;
    update();
  }

  /// ---- Show Country Code Picker ------------>>>
  void showCountryCodePicker() async {
    final country = await showCountryPickerSheet(
      Get.context!,
      title: Text(
        Strings.chooseCountry,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      cancelWidget: Positioned(
        right: 8,
        top: 4,
        bottom: 0,
        child: TextButton(
          child: Text(
            Strings.cancel,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pop(Get.context!),
        ),
      ),
    );

    if (country != null) {
      selectedCountry = country;
      update();
    }
  }

  /// ---- Login Api ------------>>>
  phoneVerificationAPI() async {
    isLoading!.value = true;

    var formData = ({
      'phone': selectedCountry!.callingCode + phoneNumberController.text.trim(),
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.phoneVerification,
      params: formData,
      isLoading: false,
    );

    CommonTokenResponseModel model = CommonTokenResponseModel.fromJson(data);
    isLoading!.value = false;
    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      Get.to(() => const SignInOTPScreen(), binding: SignInOTPBindings(), arguments: [selectedCountry!.callingCode, phoneNumberController.text.trim(), model.token]);
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }

  bool validation() {
    if (phoneNumberController.text.isEmpty) {
      phoneNumberError!.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vPhoneNumber);
    } else if (!utils.phoneValidator(phoneNumberController.text)) {
      phoneNumberError!.value = true;
      utils.showSnackBar(context: Get.context!, message: Strings.vValidPhoneNumber);
    } else {
      phoneNumberError!.value = false;
      return true;
    }
    return false;
  }

  /// ---- Social Facebook Login ------------>>>
  facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200),birthday,friends,gender,link,first_name,last_name",
      );

      printAction('''
            Logged in!

            Facebook Id: ${accessToken.userId}
            Email: ${userData['email']};
            Name: ${userData['name']};
            Profile Pic: ${userData['picture']['data']['url']};
      ''');

      id = accessToken.userId;
      email = userData['email'];
      name = userData['name'];
      photoUrl = userData['picture']['data']['url'];
      mediaName = "facebook";
      update();

      socialLoginAPI();
    } else if (result.status == LoginStatus.cancelled) {
      utils.showSnackBar(message: 'Login cancelled by the user.', context: Get.context!);
    } else if (result.status == LoginStatus.failed) {
      utils.showSnackBar(message: 'Something went wrong with the login process.\nHere\'s the error Facebook gave us: ${result.message}', context: Get.context!);
    }
  }

  /// ---- Social Google Login ------------>>>
  GoogleSignInAccount? currentUser;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  signInWithGoogle() {
    printAction("currentUser --------- >>>>> ($currentUser)");
    googleSignIn.signIn();
    return "";
  }

  void successGoogle() {
    printAction("successGoogle --------- >>>>> ($currentUser)");
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      currentUser = account;

      if (account != null) {
        printAction('''
          Google Logged in!

          Google Id: ${account.id}
          Email: ${account.email};
          Name: ${account.displayName ?? ""};
          Profile Pic: ${account.photoUrl ?? ""};
      ''');

        id = account.id;
        email = account.email;
        name = account.displayName ?? "";
        photoUrl = account.photoUrl ?? "";
        mediaName = "google";
        update();

        await account.clearAuthCache();
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
        currentUser = null;

        socialLoginAPI();
      }
    });
  }

  /// ---- Social Apple Login ------------>>>
  Future<String> appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.app.beepCarWash.appleLogin',
        redirectUri: Uri.parse(
          'https://com.app.beepCarWash.appleLogin/callbacks/sign_in_with_apple',
        ),
      ),
      nonce: 'example-nonce',
      state: 'example-state',
    );

    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'com.app.beepCarWash.appleLogin',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null) 'firstName': credential.givenName!,
        if (credential.familyName != null) 'lastName': credential.familyName!,
        'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    printAction('''
          Apple Logged in!

          Google Id: ${credential.userIdentifier}
          Email: ${credential.email};
          Name: ${"${credential.givenName!} ${credential.familyName!}"};
          Profile Pic: "";
      ''');

    id = credential.userIdentifier!;
    email = credential.email!;
    name = "${credential.givenName ?? ""} ${credential.familyName ?? ""}";
    photoUrl = "";
    mediaName = "apple";
    update();

    socialLoginAPI();
    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );
    printAction("session: ------------>$session");
    return "";
  }

  /// ---- Social Login Api ------------>>>
  socialLoginAPI() async {
    var formData = ({
      'social_id': id,
      'name': name,
      'email': email,
      'avatar': photoUrl,
      'device_id': getStorage.readString(getStorage.deviceId),
      'media_name': mediaName,
    });
    final data = await APIFunction().postApiCall(
      context: Get.context!,
      apiName: Constants.socialLogin,
      params: formData,
    );

    OTPVerificationResponseModel model = OTPVerificationResponseModel.fromJson(data);

    if (model.code == 200) {
      utils.showToast(context: Get.context!, message: model.msg!);
      userDataModel.firstName = model.userDetail!.name!.split(" ").first;
      userDataModel.lastName = model.userDetail!.name!.split(" ").last;
      userDataModel.email = model.userDetail!.email;
      userDataModel.cCode = "";
      userDataModel.phoneNumber = "";
      userDataModel.token = model.token;
      userDataModel.profileImage = model.userDetail!.avatar!;
      userDataModel.referralCode = model.userDetail!.referralCode!;
      update();
      getStorage.saveObject(getStorage.loginData, userDataModel);
      Get.off(() => const DrawerScreen(), binding: DrawerBindings());
    } else if (model.code == 201) {
      utils.showSnackBar(context: Get.context!, message: model.msg!);
    }
  }
}
