import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import '../../../data/repositories/user/user_repositories.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Repository instance for fetching user data
  final UserRepository userRepository = Get.put(UserRepository());

  final profileLoading = false.obs;
  // Reactive user model
  final Rxn<UserModel> _user = Rxn<UserModel>();


  // Getter to access user data
  UserModel? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }


  Future<void> loadUserData() async {
    try {
      profileLoading.value = true;
      // Check if a user is authenticated
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        _user.value = UserModel.empty();
        return;
      }

      //  Fetch user record via Repository
      final userRecord = await userRepository.fetchUserDetails();

      // Determine correct collection dynamically
      String collectionName = userRecord.userType.toLowerCase() == "company" ? "companies" : "candidates";

      // Fetch Firestore document
      final doc = await FirebaseFirestore.instance.collection(collectionName).doc(uid).get();

      if (doc.exists) {
        _user.value = UserModel.fromSnapshot(doc);
        profileLoading.value = false;
      } else {
        _user.value = UserModel.empty();

      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not loaded',
        message: 'Something went wrong while fetching your information.',
      );
    }
  }

  ///  Saves user record dynamically (supports both user types)
  Future<void> saveUserRecord(UserModel user) async {
    try {
      String collectionName = user.userType.toLowerCase() == "company" ? "companies" : "candidates";
      await FirebaseFirestore.instance.collection(collectionName).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw 'Firebase error: ${e.code}';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///  Updates user details
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      String collectionName = updatedUser.userType.toLowerCase() == "company" ? "companies" : "candidates";
      await FirebaseFirestore.instance.collection(collectionName).doc(updatedUser.id).update(updatedUser.toJson());

      _user.value = updatedUser;
      update();
    } catch (e) {
      throw 'Something went wrong while updating user details';
    }
  }

  /// Removes user record
  Future<void> removeUserRecord(String userId, String userType) async {
    try {
      String collectionName = userType.toLowerCase() == "company" ? "companies" : "candidates";
      await FirebaseFirestore.instance.collection(collectionName).doc(userId).delete();

      _user.value = null;

      update();
    } catch (e) {
      throw 'Something went wrong while removing the user record';
    }
  }
}