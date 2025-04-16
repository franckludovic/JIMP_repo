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

  /// Function to save company data to Firestore.
  Future<void> saveUserRecord(CompanyModel company) async {
    try {
      String collectionName = "companies";
      await _db.collection(collectionName).doc(company.id).set(company.toJson());
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

  /// Fetch company details based on the authenticated company's ID.
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

  /// Fetch full CompanyModel by ID
  Future<CompanyModel> fetchCompanyById(String companyId) async {
    try {
      final doc = await _db.collection('companies').doc(companyId).get();
      if (doc.exists) {
        return CompanyModel.fromSnapshot(doc);
      } else {
        throw 'Company not found';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching company details';
    }
  }

  /// Update company data in Firestore.
  Future<void> updateUserDetails(CompanyModel updatedCompany) async {
    try {
      await _db.collection("companies").doc(updatedCompany.id).update(updatedCompany.toJson());
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

  /// Update a single field in a company's document (if needed).
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

  /// Remove a company's record from Firestore.
  Future<void> removeUserRecord(String companyId) async {
    try {
      await _db.collection("companies").doc(companyId).delete();
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

  /// Fetch all branches for a given company.
  Future<List<CompanyBranch>> fetchCompanyBranches(String companyId) async {
    try {
      final doc = await _db.collection('companies').doc(companyId).get();
      if (doc.exists) {
        final company = CompanyModel.fromSnapshot(doc);
        return company.branches;
      } else {
        throw 'Company not found';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching branches';
    }
  }

  Future<void> incrementTotalListings(String companyId) async {
    try {
      await _db.collection("companies").doc(companyId).update({
        'totalListings': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while updating the listing count';
    }
  }

  Future<List<CompanyModel>> fetchAllCompanies() async {
    try {
      final snapshot = await _db.collection('companies').get();
      final companies = snapshot.docs.map((doc) => CompanyModel.fromSnapshot(doc)).toList();
      return companies;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }


}
