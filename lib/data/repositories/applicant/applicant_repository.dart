// lib/repositories/applicant_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/controllers/applicant_controller.dart';
import 'package:project_bc_tuto/features/Applications/models/applicant_model.dart';
import 'package:project_bc_tuto/features/Applications/models/quiz_submision_model.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
import 'package:project_bc_tuto/utils/exceptions/firebase_exceptions.dart';
import 'package:project_bc_tuto/utils/exceptions/format_exceptions.dart';

/// Repository for managing applicant data in Firestore.
class ApplicantRepository extends GetxController {
  static ApplicantRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  /// Applies for a job posting by creating a new applicant document.
  Future<void> applyToJob({
    required UserModel user,
    required PostingModel posting,
    String? coverLetterUrl,
    String? resumeUrl,
  }) async {
    try {
      final docRef = _db.collection('applicants').doc();
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
        appliedAt: DateTime.now(),
        quizRequired: posting.quizRequired,
        quizStatus: QuizStatus.notStarted,
        attemptedQuizVersion: posting.quizVersion,
        quizSubmission: null,
        quizScore: null,
        quizPassed: false,
        profileImageUrl: user.profilePicture,
        matchScore: null,
      );
      await docRef.set(applicant.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  /// Fetches all applicants (for admin or debug purposes).
  Future<List<ApplicantModel>> getApplicants() async {
    try {
      final snapshot = await _db.collection('applicants').get();
      return snapshot.docs
          .map((doc) => ApplicantModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch applicants: $e');
    }
  }

  /// Fetches applications for the given company ID.
  Future<List<ApplicantModel>> fetchApplicantsByCompanyId(String companyId) async {
    try {
      final snapshot = await _db
          .collection('applicants')
          .where('companyId', isEqualTo: companyId)
          .orderBy('appliedAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ApplicantModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch applicants by company: $e');
    }
  }

  /// Fetches applications submitted by the current user (one-time).
  Future<List<ApplicantModel>> fetchUserApplications() async {
    if (_currentUser == null) {
      throw Exception('User not authenticated');
    }
    try {
      final snapshot = await _db
          .collection('applicants')
          .where('userId', isEqualTo: _currentUser!.uid)
          .orderBy('appliedAt', descending: true)
          .get();
      return snapshot.docs
          .map((doc) => ApplicantModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch user applications: $e';
    }
  }

  /// Provides a real-time stream of the current user's applications.
  Stream<List<ApplicantModel>> streamUserApplications() {
    if (_currentUser == null) {
      return const Stream.empty();
    }
    return _db
        .collection('applicants')
        .where('userId', isEqualTo: _currentUser!.uid)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => ApplicantModel.fromSnapshot(doc))
        .toList());
  }

  /// Updates quiz submission details for an application.
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
    } catch (e) {
      throw 'Failed to update quiz submission: $e';
    }
  }

  /// Fetches the job title for a given job/posting ID.
  Future<String?> getJobTitleById(String jobId) async {
    try {
      final doc = await _db.collection('postings').doc(jobId).get();
      return doc.data()?['jobTitle'] as String?;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching job title for $jobId: $e');
      }
      return null;
    }
  }

  Future<String?> getCompanyLogoById(String companyId) async {
    try {
      final doc = await _db.collection('companies').doc(companyId).get();
      return doc.data()?['logoUrl'];
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching job title for $companyId: $e');
      }
      return null;
    }
  }

  // Get applications for a user
  Stream<List<ApplicantModel>> getUserApplications(String userId) {
    return _db.collection('applicants')
        .where('userId', isEqualTo: userId)
        .orderBy('appliedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ApplicantModel.fromSnapshot(doc))
        .toList());
  }

  // Update application status (for companies)
  Future<void> updateApplicationStatus({
    required String applicantId,
    required ApplicantApplicationStatus status,
    Timestamp? interviewDate,
  }) async {
    await _db.collection('applicants').doc(applicantId).update({
      'status': status.name,
      'interviewDate': interviewDate,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get applications for a company's postings
  Stream<List<ApplicantModel>> getCompanyApplications(String companyId) {
    return _db.collection('applicants')
        .where('companyId', isEqualTo: companyId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ApplicantModel.fromSnapshot(doc))
        .toList());
  }
}
