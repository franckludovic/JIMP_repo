import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/reposiories/user/user_repository.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

import '../../../../data/reposiories/authentication/authentication_repository.dart';
import '../../models/user/user_model.dart';
import '../../screens/Sign_up/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///variable
  final hidePassword = true.obs;// Observable for handing password
  final privacyPolicy = true.obs;// Observable for checking privacy policies
  final email = TextEditingController(); //controller for email input
  final lastName = TextEditingController(); //controller for firstname
  final firstName = TextEditingController(); //controller for last name
  final username = TextEditingController(); //controller for user name
  final password = TextEditingController(); //controller for password
  final phoneNumber = TextEditingController(); //controller for phone number
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); //Form key for form validation

  ///--Sign up

  void signup() async {
    try {
      //start loading
      JFullScreenLoader.openLoadingDialog('We are processing your information...', JImages.docerAnimation);


      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        //Remove Loader
        JFullScreenLoader.stopLoading();
        return;
      }

      //form validating
      if(!signupFormKey.currentState!.validate()) {
        //Remove Loader
        JFullScreenLoader.stopLoading();
        return;
      }


        //privacy policy check
        if(!privacyPolicy.value) {
          JLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must accept to read and agree to the Privacy Policy & Terms of Use',
          );
        }


        //register user in firebase authentication can save user data in firebase
        final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPAssword(email.text.trim(), password.text.trim());


        //save authentication user data in the firebase firestore
        final newUser = UserModel(
            id: userCredential.user!.uid,
            firstName: firstName.text.trim(),
            lastName: lastName.text.trim(),
            email: email.text.trim(),
            username: username.text.trim(),
            phoneNumber: phoneNumber.text.trim(),
            profilePicture: ""
        );


        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserRecord(newUser);

        //Remove Loader
        JFullScreenLoader.stopLoading();

        //Show success screen
        JLoaders.successSnackBar(title: 'Congratulation', message: 'Your account has been Created! Verify email to continue.');

        //Move to verification email screen
        Get.to(() => const VerifyEmailScreen());

    }catch (e) {
      //Remove Loader
      JFullScreenLoader.stopLoading();

      //show some generic error to the user
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());

    }
  }
}