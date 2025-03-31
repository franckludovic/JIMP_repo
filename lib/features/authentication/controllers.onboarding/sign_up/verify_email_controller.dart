import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/success_screen/success_screen.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// send email whenever verification screen appears $ set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  ///Send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: "Email sent",
          message: 'Please check you Mail box and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh snap", message: e.toString());
    }
  }

  ///Timer to automatically redirect on EMail Verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(
          () => SuccessScreen(
              image: JImages.successfullyRegisterAnimation,
              title: JTexts.yourAccountCreatedTitle,
              subTitle: JTexts.yourAccountCreatedSubTitle,
              onPressed: () => Get.offAll(
                    () => AuthenticationRepository.instance.screenRedirect(),
              )
          ),
        );
      }
    });
  }

  /// Manualy check if email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(
            () => SuccessScreen(
            image: JImages.successfullyRegisterAnimation,
            title: JTexts.yourAccountCreatedTitle,
            subTitle: JTexts.yourAccountCreatedSubTitle,
            onPressed: () => Get.off(
                  () => AuthenticationRepository.instance.screenRedirect(),
            )
        ),
      );
    }
  }
}
