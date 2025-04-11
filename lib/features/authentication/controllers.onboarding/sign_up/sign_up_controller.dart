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
  final profileUrl = TextEditingController();

  // Location and education (Step 2)
  final country = TextEditingController();
  final region = TextEditingController();
  final city = TextEditingController();
  final localAddress = TextEditingController();
  final educationLevel = TextEditingController();
  final schoolAttended = TextEditingController();


  final selfDescription = TextEditingController();
  final resume = TextEditingController();
  final opportunityType = ''.obs;
  final linkedin = TextEditingController();
  final github = TextEditingController();
  final portfolio = TextEditingController();
  final jobCategory = "".obs;
  final jobTypePreference = TextEditingController();


  RxList<LanguageEntry> languages = RxList<LanguageEntry>();
  RxList<String> hobbies = RxList<String>();
  RxList<SkillEntry> skillEntries = RxList<SkillEntry>();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  bool validateStep(int step) {
    switch (step) {
      case 1:
        if (email.text.trim().isEmpty ||
            firstName.text.trim().isEmpty ||
            lastName.text.trim().isEmpty ||
            username.text.trim().isEmpty ||
            password.text.trim().isEmpty ||
            phoneNumber.text.trim().isEmpty ||
            country.text.trim().isEmpty ||
            region.text.trim().isEmpty ||
            city.text.trim().isEmpty ||
            localAddress.text.trim().isEmpty ||
            educationLevel.text.trim().isEmpty ||
            schoolAttended.text.trim().isEmpty) {
          return false;
        }
        break;
      case 2:
        if (jobTypePreference.text.trim().isEmpty || skillEntries.isEmpty) {
          return false;
        }
        break;
      case 3:
        if (selfDescription.text.trim().isEmpty ||
            opportunityType.value.trim().isEmpty ||
            jobCategory.value.trim().isEmpty) {
          return false;
        }
        break;
      case 4:
        if (languages.isEmpty) {
          return false;
        }
        break;
      default:
        break;
    }
    return true;
  }


  Future<void> signupFinal() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', JImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate the entire form ()
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        JLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
          'To create an account, you must accept the Privacy Policy & Terms of Use',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register candidate using Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Build the candidate model with all fields from the controller.
      final newUser = UserModel(
        userType: 'Candidate',
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
        profilePicture: profileUrl.text.trim(),
        skills: skillEntries.toList(),
        selfDescription: selfDescription.text.trim(),
        jobTypePreference: jobTypePreference.text.trim(),
        languages: languages.toList(),
        hobbies: hobbies.toList(),
        resume: resume.text.trim(),
        linkedin: linkedin.text.trim(),
        github: github.text.trim(),
        portfolio: portfolio.text.trim(),
        opportunityType: opportunityType.value,
        jobCategory: jobCategory.value,
      );


      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify your email to continue.');

      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }
}
