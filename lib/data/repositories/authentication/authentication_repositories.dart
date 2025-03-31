
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/verify_email.dart';
import 'package:project_bc_tuto/features/authentication/screens/onboarding/onboarding.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import 'package:project_bc_tuto/navigation_menu_company.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';
import '../../../features/Applications/guess_screens/main_landing_page/main_landing_page.dart';

import '../../../features/authentication/compamy_screens/login/login_company.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../storage_device.dart';



class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final userType = StorageService.getUserType();


  ///Called from main.dart app on launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }


  ///Function to show relevant Screen
  screenRedirect() async {

    final User? user = _auth.currentUser;

    if(user != null){
      //if the usr is logged in
      if(user.emailVerified && userType == 'Candidate'){
        Get.offAll(() => CandidateNavigationMenu());
      }else if(user.emailVerified && userType == 'Company'){
        Get.offAll(() => CompanyNavigationMenu());
      }else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    }else{
      //local storage
      deviceStorage.writeIfNull('isFirstTime', true);

      if (deviceStorage.read('isFirstTime') != true) {

        if (userType == "Company") {
          Get.offAll(const CompagnyLoginScreen());
        } else if (userType == "Candidate") {
          Get.offAll(() => const CandidateLoginScreen());
        }else if (userType == null ){
          Get.offAll(const LandingGuestPage());
        }
      }else {
        Get.offAll(const OnboardingScreen());
      }
    }






  }

  /*--------Email and password Sign in----------------*/

  ///[EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword (String email, String password) async {
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
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


  ///[EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
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

/// Mail verification
  Future<void> sendEmailVerification() async {
    try{
      await _auth.currentUser?.sendEmailVerification();
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


/*------------------------- -/end user Federated identity & social sign in--------------------------*/
///[Logout USer ] - valid for any authentication.
Future<void> logout () async {
  try{
    await FirebaseAuth.instance.signOut();
    userType == 'Company' ? Get.offAll(() => const CompagnyLoginScreen()) : Get.offAll(() => CandidateLoginScreen());
  }on FirebaseAuthException catch (e) {
    throw TFirebaseAuthException(e.code).message;
  }on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  }on FormatException catch (_) {
    throw const TFormatException();
  }on PlatformException catch(e){
    throw TPlatformException(e.code).message;
  }catch (e) {
    throw 'Something went wrong. Please try again';
  }
}

///[Delete USer] - Remove user Auth firebase Account.

}
