import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variable
  final hidePassword = true.obs;// Observabel for hinding pasword
  final privacyPolicy = true.obs;// Observabel for hinding pasword
  final email = TextEditingController(); //controller for email input
  final lastName = TextEditingController(); //controller for firstname
  final firstName = TextEditingController(); //controller for last name
  final userName = TextEditingController(); //controller for user name
  final password = TextEditingController(); //controller for password
  final phoneNumber = TextEditingController(); //controller for phone number
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); //Form key for form validation

  ///--Sign up

  Future<void> signup() async {
    try {
      //start loading
      JFullScreenLoader.openLoadingDialog('We are processing your information...', JImages.docerAnimation);


      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      //form validating
      if(!signupFormKey.currentState!.validate())return;


      //privacy policy check
      if(!privacyPolicy.value) {
        JLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create account, you must accept to read and agree to the Privacy Policy & Terms of Use',
        );
      }

      //save authentication user data in the firebase firestore



      //Show success screen

      //Move to verification email screen
    }catch (e) {
      //show some generic error to the user
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    } finally {
      //remove loader
      JFullScreenLoader.stopLoading();
    }
  }
}