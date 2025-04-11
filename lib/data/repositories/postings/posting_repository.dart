import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/format_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/platform_exceptions.dart';

class PostingRepository extends GetxController {
  static PostingRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Creates a new posting in the appropriate collection.
  Future<void> createPosting(PostingModel posting) async {
    try {
      // Here, we assume all postings are saved under the "postings" collection.
      // Optionally, you could organize them by company if needed.
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

  /// Fetches a posting by ID.
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
}
