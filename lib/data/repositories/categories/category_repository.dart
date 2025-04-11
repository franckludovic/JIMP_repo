

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';

import '../../../features/Applications/models/categorie_model.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();
  
  ///Variables
 final _db = FirebaseFirestore.instance;
 
  ///Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try{
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;

    }on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///get all sub categories
  

  ///upload categories to the cloud firebase
}