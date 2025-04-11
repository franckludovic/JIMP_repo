
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/user/company_repositories.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';


// MOD: Import image picker and Cloudinary service package
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import '../../../../services/cloudinary.dart';
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

  // MOD: Instance of ImagePicker and CloudinaryService
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  // MOD: Method to pick and upload a logo image.
  Future<void> pickLogoImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? url = await _cloudinaryService.uploadImage(imageFile);
      if (url != null) {
        logoUrl.text = url;
        update(); // Trigger UI update if needed.
      }
    }
  }

  void updateBranch(int index, CompanyBranch newBranch) {
    if (index >= 0 && index < branches.length) {
      branches[index] = newBranch;
      update();
    }
  }

  void removeBranch(int index) {
    if (index >= 0 && index < branches.length) {
      branches.removeAt(index);
      update();
    }
  }

  void addNewBranch() {
    branches.add(
        CompanyBranch(
          address: CompanyAddress(
            street: '',
            city: '',
            region: '',
            country: '',
            postalCode: '',
          ),
          contactName: '',
          contactEmail: '',
          phoneNumber: '',
        )
    );
  }




  // MOD: Method to pick and upload a profile image.
  Future<void> pickProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? url = await _cloudinaryService.uploadImage(imageFile);
      if (url != null) {
        profileUrl.text = url;
        update(); // Trigger UI update if needed.
      }
    }
  }

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
        JLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'To create an account, you must accept the Privacy Policy & Terms of Use',
        );
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(officialEmail.text.trim(), password.text.trim());

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
        headquarters: headquartersAddress,
        industry: industry.value.trim(),
        registrationNumber: registrationNumber.text.trim(),
        businessLicenseUrl: businessLicense.text.trim(),
        password: password.text.trim(), // Note: Consider secure password handling.
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
        logoUrl: logoUrl.text.trim(),      // Image URL from Cloudinary
        profileUrl: profileUrl.text.trim(),  // Image URL from Cloudinary
        mlMatchScore: 0.0,
        aiRelevanceScore: 0.0,
        totalListings: 0,
        averageRating: 0.0,
        ratingCount: 0,
      );

      final companyRepository = Get.put(CompanyRepository());
      await companyRepository.saveUserRecord(newCompany);

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your company account has been created! Verify your email to continue.',
      );

      Get.to(() => VerifyEmailScreen(email: officialEmail.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }
}