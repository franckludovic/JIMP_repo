import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import '../../../data/repositories/user/company_repositories.dart';
import '../../../data/repositories/user/user_repositories.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../Applications/models/company_model.dart';
import '../../authentication/screens/login/login.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();


  final CompanyRepository companyRepository = Get.put(CompanyRepository());

  // Reactive variable to hold user data.
  final Rxn<CompanyModel> _user = Rxn<CompanyModel>();

  final hidePassword =false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();

  // A reactive flag to indicate if the profile is loading.
  final profileLoading = false.obs;

  // Getter for accessing current user.
  CompanyModel? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchCompany();
  }

  /// Safely updates the user's name using the copyWith method on CompanyModel.
  void updateUserName(String first) {
    if (_user.value != null) {
      _user.value = _user.value!.copyWith(
        companyName: first,
      );
    }
  }


  ///fetch all companies
  final CompanyRepository companyfetch = Get.put(CompanyRepository());
  RxList<CompanyModel> company = <CompanyModel>[].obs;

  Future<void> fetchCompany() async {
    try {
      final allCompanyFetch = await CompanyRepository.instance.fetchAllCompanies();
      company.assignAll(allCompanyFetch);
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  /// Loads user data from Firestore based on user type (company or candidate).
  Future<void> loadUserData() async {
    try {
      profileLoading.value = true;
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        _user.value = CompanyModel.empty();
        profileLoading.value = false;
        return;
      }

      // Fetch user record from repository (this may include cached values)
      final userRecord = await companyRepository.fetchUserDetails();

      // Determine the correct collection based on userType.
      final collectionName = userRecord.userType.toLowerCase() == "company"
          ? "companies"
          : "candidates";

      // Fetch the Firestore document for the user.
      final doc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(uid)
          .get();

      if (doc.exists) {
        _user.value = CompanyModel.fromSnapshot(doc);
      } else {
        _user.value = CompanyModel.empty();
      }
    } catch (e) {
      JLoaders.warningSnackBar(
        title: 'Data not loaded',
        message: 'Something went wrong while fetching your information.',
      );
    } finally {
      profileLoading.value = false;
    }
  }

  /// Saves user record to the appropriate Firestore collection.
  Future<void> saveUserRecord(CompanyModel user) async {
    try {
      final collectionName = user.userType.toLowerCase() == "company"
          ? "companies"
          : "candidates";
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw 'Firebase error: ${e.code}';
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Updates user document and local reactive model.
  Future<void> updateUserDetails(CompanyModel updatedUser) async {
    try {
      final collectionName = updatedUser.userType.toLowerCase() == "company"
          ? "companies"
          : "candidates";
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
      _user.value = updatedUser;
      update();
    } catch (_) {
      throw 'Something went wrong while updating user details.';
    }
  }

  /// Deletes user document and clears the reactive model.
  Future<void> removeUserRecord(String userId, String userType) async {
    try {
      final collectionName = userType.toLowerCase() == "company"
          ? "companies"
          : "candidates";
      await FirebaseFirestore.instance.collection(collectionName).doc(userId).delete();
      _user.value = null;
      update();
    } catch (_) {
      throw 'Something went wrong while removing the user record.';
    }
  }

  // delete account warning
  void deleteAccountWarning() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(JSizes.md),
      title: 'Delete Account',
      middleText: 'Are you Sure you want to delete account permenently? this action is not reversible and all of your data will be removed permanently',
      confirm: ElevatedButton(
          onPressed: () async => deleteAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: JSizes.lg), child: Text("Delete"))
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
      ),
    );
  }

  void deleteAccount() async{
    try{
      TFullScreenLoader.openLoadingDialog('Processing', JImages.docerAnimation);

      ///first re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty) {
        // re verify auth email
        if(provider == 'google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const CandidateLoginScreen());
        }else if (provider == 'password'){
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    }catch(e){
      TFullScreenLoader.stopLoading();
      JLoaders.warningSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try{
      TFullScreenLoader.openLoadingDialog('Processing', JImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormkey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticationWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const CandidateLoginScreen());

    }catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString() );
    }
  }
}