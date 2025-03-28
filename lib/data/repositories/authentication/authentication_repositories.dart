
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_bc_tuto/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';
import '../../../features/authentication/compamy_screens/login/login_company.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../storage_device.dart';



class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;


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


    // deviceStorage.writeIfNull('isFirstTime', true);
    // deviceStorage.read('isFirstTime') != true
    //     ? Get.offAll(() => const CandidateNavigationMenu())
    //     : Get.offAll(const OnboardingScreen());

    deviceStorage.writeIfNull('isFirstTime', true);
    if (deviceStorage.read('isFirstTime') != true) {

      if (userType == "Company") {
        Get.offAll(const CompagnyLoginScreen());
      } else if (userType == "Candidate") {
        Get.offAll(() => const CandidateNavigationMenu());
      }
    }else {
      Get.offAll(const OnboardingScreen());
    }
  }

  /*--------Email and password Sign in----------------*/

  ///[EmailAuthentication] - SignIn


  ///[EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPAssword(String email, String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch (e) {
      throw 'Something went Wrong. please try again';
    }
  }


///[ReAuthentication] - ReAuthentication User


///[EmailVerification] - Mail Verification


///[EmailAuthentication] - Forget Password


/*-----------------------Federated identity & Social sign in-----------------*/

///[GoogleAuthentication]   -  Google


///[FacebookAuthentication] - Facebook


///[Logout USer ] - valid for any authentication.


///[Delete USer] - Remove user Auth firebase Account.

}
