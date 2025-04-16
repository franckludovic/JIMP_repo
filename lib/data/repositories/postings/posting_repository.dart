import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/format_exceptions.dart';

import '../authentication/authentication_repositories.dart';
import '../user/company_repositories.dart';


class PostingRepository extends GetxController {
  static PostingRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? companyId = AuthenticationRepository.instance.authUser?.uid;

  /// Creates a new posting in the appropriate collection.
  Future<void> createPosting(PostingModel posting) async {
    try {
      await _db.collection('postings').add(posting.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on Exception catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  /// Updates an existing posting.
  Future<void> updatePosting(PostingModel posting) async {
    try {
      await _db.collection('postings').doc(posting.id).update(posting.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on Exception catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  ///fetch all postings
  Future<List<PostingModel>> fetchAllPostings() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('postings').get();
      // Convert each document snapshot into a PostingModel object
      final postings = snapshot.docs
          .map((doc) => PostingModel.fromSnapshot(doc))
          .toList();
      return postings;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching postings: ${e.toString()}';
    }
  }

  Future<List<PostingModel>> getFavoritePostings(List<String> ponstingId) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('postings').where(FieldPath.documentId, whereIn: ponstingId).get();
      
      return snapshot.docs.map((querySnapshot) => PostingModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching postings: ${e.toString()}';
    }
  }

  /// Fetches all postings made by a specific company.
  Future<List<PostingModel>> fetchPostingsByCompany(String companyId) async {
    try {
      final snapshot = await _db
          .collection('postings')
          .where('companyId', isEqualTo: companyId)
          .get();
      final postings = snapshot.docs
          .map((doc) => PostingModel.fromSnapshot(doc))
          .toList();
      return postings;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }


  /// Fetches a posting by its ID.
  Future<PostingModel> fetchPosting(String postingId) async {
    try {
      final doc = await _db.collection('postings').doc(postingId).get();
      if (doc.exists) {
        return PostingModel.fromSnapshot(doc);
      } else {
        throw "Posting not found";
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  /// Removes a posting.
  Future<void> removePosting(String postingId) async {
    try {
      await _db.collection('postings').doc(postingId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  // In your controller:
  void updatePostings(PostingModel posting, {String? newJobTitle, /* other fields */}) async {
    final updatedPostings = posting.copyWith(
      jobTitle: newJobTitle ?? posting.jobTitle,
      // other fields updated accordingly
    );
    await PostingRepository.instance.updatePosting(updatedPostings);
  }


}

