import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';

import '../../../features/Applications/models/sub_categorie_model.dart';

class SubCategoryRepository extends GetxController {
  static SubCategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get all subcategories that belong to a given parent category.
  Future<List<SubCategoryModel>> getSubCategoriesByParent(String parentCategory) async {
    try {
      final snapshot = await _db
          .collection('subcategories')
          .where('parentCategory', isEqualTo: parentCategory)
          .get();
      final list = snapshot.docs
          .map((document) => SubCategoryModel.fromJson(document.data(), document.id))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Creates a new subcategory.
  Future<void> createSubCategory(SubCategoryModel subCategory) async {
    try {
      await _db.collection('subcategories').doc(subCategory.id).set(subCategory.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Updates an existing subcategory document in Firestore.
  Future<void> updateSubCategory(SubCategoryModel subCategory) async {
    try {
      await _db.collection('subcategories').doc(subCategory.id).update(subCategory.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Deletes a subcategory document from Firestore.
  Future<void> deleteSubCategory(String id) async {
    try {
      await _db.collection('subcategories').doc(id).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}
