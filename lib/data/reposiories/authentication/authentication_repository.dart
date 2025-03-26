import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_bc_tuto/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import '../../../features/authentication/compamy_screens/login/login_company.dart';
import '../../storageService.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final deviceStorage = GetStorage();


  ///Called from main.dart app on launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }


  ///Function to show relevant Screen
  screenRedirect() async {
    //local storage

    final userType = StorageService.getUserType();


    if(kDebugMode) {
      print("=============== Get Storage  =================");
      print(deviceStorage.read('isFirstTime'));
    }


    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const CandidateNavigationMenu())
        : Get.offAll(const OnboardingScreen());

    // deviceStorage.writeIfNull('isFirstTime', true);
    // if (deviceStorage.read('isFirstTime') != true) {
    //
    //   if (userType == "Company") {
    //     Get.offAll(const CompagnyLoginScreen());
    //   } else if (userType == "Candidate") {
    //     Get.offAll(() => const CandidateNavigationMenu());
    //   }
    // }else {
    //   Get.offAll(const OnboardingScreen());
    // }
   }

  /*--------Email and password Sign in----------------*/

  ///[EmailAuthentication] - SignIn


  ///[EmailAuthentication] - Register


  ///[ReAuthentication] - ReAuthentication User


  ///[EmailVerification] - Mail Verification


  ///[EmailAuthentication] - Forget Password


  /*-----------------------Federated identity & Social sign in-----------------*/

  ///[GoogleAuthentication]   -  Google


  ///[FacebookAuthentication] - Facebook


  ///[Logout USer ] - valid for any authentication.


  ///[Delete USer] - Remove user Auth firebase Account.

}