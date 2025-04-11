
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/format_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';

import '../authentication/authentication_repositories.dart';



class CompanyRepository extends GetxController {
  static CompanyRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Function to save user data to firebase
  Future<void> saveUserRecord(CompanyModel user) async {
    try {

      String collectionName = "companies" ;

      await _db.collection(collectionName).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<CompanyModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("companies")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return CompanyModel.fromSnapshot(documentSnapshot);
      } else {
        return CompanyModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///function to update user data in firebase.
  Future<void> updateUserDetails(CompanyModel updateUser) async {
    try {
      await _db.collection("companies").doc(updateUser.id).update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///update any field in specific User Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("companies").doc().update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Function to remove company
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("companies").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



///Function to fetch user detail based on id
///function to update user data in firebase.
///update any field in specific User Collection
}