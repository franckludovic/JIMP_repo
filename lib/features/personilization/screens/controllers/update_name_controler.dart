import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/user/user_repositories.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/features/personilization/screens/profile/Profile.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetches user data and populates the name controllers.
  Future<void> initializeNames() async {
    firstName.text = userController.user?.firstName ?? '';
    lastName.text = userController.user?.lastName ?? '';
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are updating your information...', JImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Create an updated user model using copyWith.
      final updatedUser = userController.user!.copyWith(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
      );

      // Update user details in Firestore via the UserController.
      await userController.updateUserDetails(updatedUser);

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(title: 'Congratulations!', message: 'Your Name has been updated');
      Get.to(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}