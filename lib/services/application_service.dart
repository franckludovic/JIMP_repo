// lib/services/application_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../features/Applications/models/applicant_model.dart';

class ApplicationService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitApplication(ApplicantModel application) async {
    await _firestore.collection('applications').doc(application.id).set(
      application.toJson(),
    );

    // Update application count in the job posting
    await _firestore.collection('postings').doc(application.jobId).update({
      'applicationCount': FieldValue.increment(1),
    });
  }

  Future<bool> isQuizRequired(String jobId) async {
    final doc = await _firestore.collection('postings').doc(jobId).get();
    return doc.exists ? (doc.data()?['quizRequired'] ?? false) : false;
  }

  Future<ApplicantApplicationStatus> getApplicationStatus(String applicationId) async {
    final doc = await _firestore.collection('applications').doc(applicationId).get();
    return doc.exists
        ? ApplicantModel.fromSnapshot(doc).status
        : ApplicantApplicationStatus.pending;
  }

  Future<bool> checkQuizVersionMatch(String jobId, int attemptedVersion) async {
    final doc = await _firestore.collection('postings').doc(jobId).get();
    return doc.exists ? (doc.data()?['quizVersion'] == attemptedVersion) : false;
  }

  Future<void> updateApplicationStatus(
      String applicationId, ApplicantApplicationStatus status) async {
    await _firestore.collection('applications').doc(applicationId).update({
      'status': status.name,
    });
  }

  Future<ApplicantModel?> getApplication(String applicationId) async {
    final doc = await _firestore.collection('applications').doc(applicationId).get();
    return doc.exists ? ApplicantModel.fromSnapshot(doc) : null;
  }
}