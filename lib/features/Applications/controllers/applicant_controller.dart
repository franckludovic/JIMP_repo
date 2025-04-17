// lib/controllers/applicant_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bc_tuto/features/Applications/models/applicant_model.dart';
import 'package:project_bc_tuto/features/Applications/models/quiz_submision_model.dart';
import 'package:project_bc_tuto/utils/helpers/network_manager.dart';
import 'package:project_bc_tuto/utils/popups/full_screen_loader.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

import '../../../data/repositories/applicant/applicant_repository.dart';
import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../utils/constants/image_strings.dart';
import '../models/posting_model.dart';
import '../models/user_model.dart';

class ApplicantController extends GetxController {
  static ApplicantController get instance => Get.find();

  // Observable state for loading and error handling.
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final String? companyId = AuthenticationRepository.instance.authUser?.uid;

  // Use this key if you have a form for additional inputs (e.g., cover letter, quiz answers).
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Repository reference.
  final controller = Get.put(ApplicantRepository());
  final ApplicantRepository _repository = ApplicantRepository.instance;


  @override
  void onInit() {
    super.onInit();
    loadApplicantByCompany(companyId!);
  }

  /// Validates the form. Returns true if the form is valid.
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Applies to a job posting.
  ///
  /// [candidate] is the current UserModel.
  /// [posting] is the PostingModel of the job.
  /// [coverLetterUrl] and [resumeUrl] are optional overrides.
  Future<void> applyForJob({
    required UserModel candidate,
    required PostingModel posting,
    String? coverLetterUrl,
    String? resumeUrl,
  }) async {
    if (!validateForm()) return;

    isLoading.value = true;
    errorMessage.value = '';
    TFullScreenLoader.openLoadingDialog(
        'Submitting your application...', JImages.docerAnimation);

    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        errorMessage.value = 'No internet connection.';
        JLoaders.errorSnackBar(title: 'Error', message: errorMessage.value);
        return;
      }

      // Submit the application.
      await _repository.applyToJob(
        user: candidate,
        posting: posting,
        coverLetterUrl: coverLetterUrl,
        resumeUrl: resumeUrl,
      );

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
        title: 'Success',
        message: 'Your application has been submitted successfully.',
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      errorMessage.value = e.toString();
      JLoaders.errorSnackBar(
          title: 'Application Error', message: errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  /// Updates the quiz submission for an already applied application.
  ///
  /// This method should be called when a quiz is available and a candidate completes it.
  Future<void> updateQuizSubmission({
    required String applicantId,
    required QuizSubmission quizSubmission,
    double? quizScore,
    bool quizPassed = false,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    TFullScreenLoader.openLoadingDialog(
        'Submitting your quiz answers...', JImages.docerAnimation);

    try {
      await _repository.updateQuizSubmission(
        applicantId: applicantId,
        quizSubmission: quizSubmission,
        quizScore: quizScore,
        quizPassed: quizPassed,
        quizStatus: QuizStatus.completed, // Set to completed; adjust as needed.
      );

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
        title: 'Quiz Submitted',
        message: 'Your quiz has been submitted successfully.',
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      errorMessage.value = e.toString();
      JLoaders.errorSnackBar(title: 'Quiz Error', message: errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<ApplicantModel> applicants = <ApplicantModel>[].obs;

  void loadApplicantByCompany(String companyId) async {
    try {
      final applicantFetch = await ApplicantRepository.instance
          .fetchApplicantsByCompanyId(companyId);

      applicants.assignAll(applicantFetch);
    } catch (e) {
      // Handle error
    }
  }

  Future<ApplicantModel?> _getCurrentUserApplicant(String jobId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final query = await FirebaseFirestore.instance
        .collection('applicants')
        .where('jobId', isEqualTo: jobId)
        .where('userId', isEqualTo: uid)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return ApplicantModel.fromSnapshot(query.docs.first);
    }

    return null;
  }


  Future<ApplicantModel?> getApplicantForJob(String jobId,
      String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('applicants')
        .where('jobId', isEqualTo: jobId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();

    if (doc.docs.isNotEmpty) {
      return ApplicantModel.fromSnapshot(doc.docs.first);
    }
    return null;
  }

  final RxList<ApplicantModel> applications = <ApplicantModel>[].obs;
  final applicantRepo = Get.put(ApplicantRepository());

  // Load user applications
  void loadUserApplications(String userId) {
    applications.bindStream(
        applicantRepo.getUserApplications(userId)
    );
  }

  // Company: Update application status
  Future<void> updateApplicationStatus({
    required String applicantId,
    required ApplicantApplicationStatus newStatus,
    DateTime? interviewDate,
  }) async {
    try {
      await applicantRepo.updateApplicationStatus(
        applicantId: applicantId,
        status: newStatus,
        interviewDate: interviewDate != null
            ? Timestamp.fromDate(interviewDate)
            : null,
      );
      JLoaders.successSnackBar(title: 'Status Updated', message: '');
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Update Failed', message: e.toString());
    }
  }

  void scheduleInterview({
    required String applicantId,
    required DateTime scheduledDateTime,
  }) async {
    try {
      await ApplicantRepository.instance.updateApplicationStatus(
        applicantId: applicantId,
        status: ApplicantApplicationStatus.interviewScheduled,
        interviewDate: Timestamp.fromDate(scheduledDateTime),
      );
      Get.snackbar("Success", "Interview scheduled for ${scheduledDateTime.toLocal()}");
    } catch (e) {
      Get.snackbar("Error", "Failed to schedule interview: $e");
    }
  }


  @override
  void dispose() {
    // Dispose of any controllers or focus nodes if needed.
    super.dispose();
  }


}