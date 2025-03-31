

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();


  ///Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();


  ///Send Reset Password Email
  sendPasswordResetEmail() async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing your request...', JImages.docerAnimation);

      //check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //validate form
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //remove scuccess screen
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to rest your password'.tr);

      //Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim(),));
    }catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());

    }
  }

  resendPasswordRestEmail(String email) async {

    try{
      TFullScreenLoader.openLoadingDialog('Processing your request...', JImages.docerAnimation);

      //check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //validate form
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove scuccess screen
      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Email sent', message: 'Email Link sent to rest your password'.tr);

    }catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());

    }
  }

}