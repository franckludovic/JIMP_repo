import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

class LoginController extends GetxController{


  ///Variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  /// -- Email and password SignIn
  Future<void> emailAndPasswordSignIN() async{
    try{
      TFullScreenLoader.openLoadingDialog("Logging you in...", JImages.docerAnimation);

      //Check connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Save Data if remember me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //login user using email and password auth
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }catch (e){
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


  ///-- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try{

      TFullScreenLoader.openLoadingDialog('Logging you in...', JImages.docerAnimation);


      //Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();


    }catch(e){
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}