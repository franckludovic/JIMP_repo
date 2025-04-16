// lib/repositories/applicant_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/controllers/applicant_controller.dart';
import 'package:project_bc_tuto/features/Applications/models/applicant_model.dart';
import 'package:project_bc_tuto/features/Applications/models/quiz_submision_model.dart';

import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/format_exceptions.dart';

import '../../../features/Applications/models/posting_model.dart';
import '../../../features/Applications/models/user_model.dart';

class ApplicantRepository extends GetxController {
  static ApplicantRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Applies for a job posting by creating a new applicant document.
  Future<void> applyToJob({
    required UserModel user,
    required PostingModel posting,
    String? coverLetterUrl,
    String? resumeUrl,
  }) async {
    try {
      // Generate a new document reference with auto-generated ID.
      DocumentReference docRef = _db.collection('applicants').doc();

      // Build the ApplicantModel.
      final applicant = ApplicantModel(
        id: docRef.id,
        userId: user.id,
        jobId: posting.id,
        fullName: user.fullName,
        email: user.email,
        companyId: posting.companyId,
        resumeUrl: resumeUrl ?? user.resume,
        coverLetterUrl: coverLetterUrl,
        status: ApplicantApplicationStatus.pending,
        appliedAt: Timestamp.now(),
        // Set quiz-related fields based on the posting.
        quizRequired: posting.quizRequired,
        quizStatus: posting.quizRequired ? QuizStatus.notStarted : QuizStatus.notStarted,
        attemptedQuizVersion: posting.quizVersion,
        quizSubmission: null, // No submission yet.
        quizScore: null,
        quizPassed: false,
        profileImageUrl: user.profilePicture,
        matchScore: null, // Set to null initially; update after ML model evaluation
      );

      // Save to Firestore.
      await docRef.set(applicant.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on Exception catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  Future<List<ApplicantModel>> getApplicants() async {
    try {
      final querySnapshot = await _db.collection('applicants').get();
      return querySnapshot.docs
          .map((doc) => ApplicantModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch applicants: $e');
    }
  }



  Future<List<ApplicantModel>> fetchApplicantsByCompanyId(String companyId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('applicants')
        .where('companyId', isEqualTo: companyId)
        .get();

    return querySnapshot.docs
        .map((doc) => ApplicantModel.fromSnapshot(doc))
        .toList();
  }




  /// Updates the quiz submission of an already applied application.
  ///
  /// This method updates the applicant document with quiz submission details.
  Future<void> updateQuizSubmission({
    required String applicantId,
    required QuizSubmission quizSubmission,
    double? quizScore,
    bool quizPassed = false,
    QuizStatus quizStatus = QuizStatus.completed,
  }) async {
    try {
      await _db.collection('applicants').doc(applicantId).update({
        'quizSubmission': quizSubmission.toMap(),
        'quizScore': quizScore,
        'quizPassed': quizPassed,
        'quizStatus': quizStatus.name,
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on Exception catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }


  Future<String?> getJobTitleById(String jobId) async {
    try {
      // Query the document in the 'postings' collection using the jobId.
      final docSnapshot =
      await FirebaseFirestore.instance.collection('postings').doc(jobId).get();

      // Check if the document exists and has data.
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data()!;
        if (kDebugMode) {
          print("Fetched document for jobId $jobId: $data");
        }
        // Return the job title field (ensure the field name is exactly 'jobTitle').
        return data['jobTitle'] as String?;
      } else {
        if (kDebugMode) {
          print("Document does not exist for jobId: $jobId");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching job title for jobId $jobId: $e");
      }
      return null;
    }
  }

  Future<void> updateApplicationStatus(String applicantId, ApplicantApplicationStatus status) async {
    await FirebaseFirestore.instance
        .collection('applicants')
        .doc(applicantId)
        .update({'status': status.name});
  }



}
