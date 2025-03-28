import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/verify_email.dart';


import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../../data/repositories/user/user_repositories.dart';
import '../../../Applications/models/user_model.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Observables and Controllers for basic account info
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  // Personal information controllers (from step 1)
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  // Additional required fields (assuming these are captured in previous steps or here)
  final country = TextEditingController();
  final region = TextEditingController();
  final city = TextEditingController();
  final localAddress = TextEditingController();
  final educationLevel = TextEditingController();
  final schoolAttended = TextEditingController();

  // Experience/Skills info (for step2)
  final jobTypePreference = TextEditingController(); // e.g., job preference input from UI

  /// A reactive list for the skill entries.
  RxList<SkillEntry> skillEntries = RxList<SkillEntry>();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///--Sign up
  Future<void> signup() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', JImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
          'In order to create account, you must accept to read and agree to the Privacy Policy & Terms of Use',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPAssword(email.text.trim(), password.text.trim());

      // Build the new user model including all required and optional fields.
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        password: password.text.trim(),
        country: country.text.trim(),
        region: region.text.trim(),
        city: city.text.trim(),
        localAddress: localAddress.text.trim(),
        educationLevel: educationLevel.text.trim(),
        schoolAttended: schoolAttended.text.trim(),
        profilePicture: "", // You can set a default or uploaded picture URL here.
        skills: skillEntries.toList(), // List of SkillEntry objects from your skill cards
        selfDescription: "", // Optionally, add a controller for self-description.
        jobTypePreference: jobTypePreference.text.trim(),
        languages: [], // You can update this later in another step.
        hobbies: [],   // You can update this later in another step.
        resume: "",
        linkedin: "",
        github: "",
        portfolio: "",
      );

      // Save user record in Firestore.
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Stop Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Navigate to email verification screen.
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }
}
