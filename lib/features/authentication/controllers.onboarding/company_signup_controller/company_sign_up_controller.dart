import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/user/company_repositories.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../Applications/models/company_model.dart';
import '../../screens/Sign_up/verify_email.dart';

class CompanySignupController extends GetxController {
  static CompanySignupController get instance => Get.find();

  /// Observables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();
  final formKeyStep4 = GlobalKey<FormState>();

  // Screen 1: Basic Company Info
  final companyName = TextEditingController();
  final password = TextEditingController();
  final RxString companySize = ''.obs;
  final country = TextEditingController();
  final region = TextEditingController();
  final city = TextEditingController();
  final localAddress = TextEditingController();
  final postalCode = TextEditingController();
  final officialEmail = TextEditingController();
  final phoneNumber1 = TextEditingController();
  final phoneNumber2 = TextEditingController();
  final logoUrl = TextEditingController();
  final profileUrl = TextEditingController();
  RxList<CompanyBranch> branches = RxList<CompanyBranch>();

  // Screen 2: Business Verification & Contact
  final RxString industry = ''.obs;
  final website = TextEditingController();
  final linkedinProfile = TextEditingController();
  final registrationNumber = TextEditingController();
  final businessLicense = TextEditingController();
  final RxString opportunityType = ''.obs;
  final RxString opportunityCategory = ''.obs;
  final description = TextEditingController();

  // Screen 3: HR Contact Info
  final hrName = TextEditingController();
  final hrTitle = TextEditingController();
  final hrEmail = TextEditingController();
  final hrPhone = TextEditingController();

  bool validateStep1() => formKeyStep1.currentState!.validate();

  bool validateStep2() => formKeyStep2.currentState!.validate();

  bool validateStep3() => formKeyStep3.currentState!.validate();

  bool validateStep4() => formKeyStep4.currentState!.validate();

  Future<void> signupFinal() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are processing your information...', JImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // if (!validateStep4()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'To create an account, you must accept the Privacy Policy & Terms of Use',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              officialEmail.text.trim(),
          password.text.trim()
      );


      final headquartersAddress = CompanyAddress(
        street: localAddress.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        region: region.text.trim(),
        postalCode: postalCode.text.trim(),
      );

      final newCompany = CompanyModel(
        id: userCredential.user!.uid,
        companyName: companyName.text.trim(),
        size: companySize.value.trim(),
        // value from dropdown
        headquarters: headquartersAddress,
        industry: industry.value.trim(),
        registrationNumber: registrationNumber.text.trim(),
        businessLicenseUrl: businessLicense.text.trim(),
        password: password.text.trim(),
        // Handle security separately
        opportunityTypes: {opportunityType.value.trim()},
        opportunityCategory: opportunityCategory.value.trim(),
        hrContact: HRContact(
          name: hrName.text.trim(),
          title: hrTitle.text.trim(),
          email: hrEmail.text.trim(),
          phone: hrPhone.text.trim(),
        ),
        branches: branches.toList(),
        officialEmail: officialEmail.text.trim(),
        phoneNumber1: phoneNumber1.text.trim(),
        phoneNumber2: phoneNumber2.text.trim(),
        description: description.text.trim(),
        verificationStatus: VerificationStatus.pending,
        website: website.text.trim(),
        linkedinProfile: linkedinProfile.text.trim(),
        logoUrl: logoUrl.text.trim(),
        profileUrl: profileUrl.text.trim(),
        mlMatchScore: 0.0,
        aiRelevanceScore: 0.0,
        totalListings: 0,
        averageRating: 0.0,
        ratingCount: 0,
      );

      final companyRepository = Get.put(CompanyRepository());
      await companyRepository.saveUserRecord(newCompany);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your company account has been created! Verify your email to continue.',
      );

      Get.to(() => VerifyEmailScreen(email: officialEmail.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }
}
