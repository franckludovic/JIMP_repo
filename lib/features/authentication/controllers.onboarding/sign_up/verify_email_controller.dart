import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';


class VerificationController extends GetxController {
  static VerificationController get instance => Get.find();

  /// send email whenever verification screen appears $ set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    super.onInit();
  }

  ///Send Email verification link
  sendEmailVerification() async{
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: "Email sent", message:'Please check you Mail box and verify your email.');
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh snap", message: e.toString());
    }
  }

  ///Timer to automatically redirect on EMail Verification


  /// Manualy check if email Verified
}