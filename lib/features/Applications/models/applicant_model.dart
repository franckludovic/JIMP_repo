import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:project_bc_tuto/features/Applications/models/quiz_submision_model.dart';

enum ApplicantApplicationStatus { pending, underReview, accepted, rejected }
enum QuizStatus { notStarted, inProgress, completed }

@immutable
class ApplicantModel {
  final String id;
  final String userId;
  final String jobId;
  //final String jobTitle;
  final String fullName;
  final String email;
  final String resumeUrl;
  final String? coverLetterUrl;
  final ApplicantApplicationStatus status;
  final Timestamp appliedAt;


  final String? companyId;
  final String? profileImageUrl;
  final double? matchScore;

  // Quiz-related fields
  final QuizSubmission? quizSubmission;
  final bool quizRequired;
  final QuizStatus quizStatus;
  final int attemptedQuizVersion;
  final double? quizScore;
  final bool quizPassed;

  const ApplicantModel({
    required this.id,

    required this.userId,
    required this.jobId,
    required this.fullName,
    required this.email,
    required this.resumeUrl,
    this.coverLetterUrl,
    this.status = ApplicantApplicationStatus.pending,
    required this.appliedAt,
    this.profileImageUrl,
    this.matchScore,
    this.quizSubmission,
    this.quizRequired = false,
    this.quizStatus = QuizStatus.notStarted,
    this.attemptedQuizVersion = 0,
    this.quizScore,
    this.quizPassed = false,
    this.companyId
  }) : assert(
  (!quizRequired || quizSubmission != null) || quizStatus == QuizStatus.notStarted,
  'If quiz is required, submission must exist when quiz is completed',
  );

  factory ApplicantModel.fromSnapshot(DocumentSnapshot snapshot) {
    final rawData = snapshot.data();
    if (rawData == null) {
      throw Exception("Applicant data is null for document ID: ${snapshot.id}");
    }
    final data = rawData as Map<String, dynamic>;

    return ApplicantModel(
      id: snapshot.id,
      userId: data['userId'],
      jobId: data['jobId'],
      fullName: data['fullName'],
      email: data['email'],
      resumeUrl: data['resumeUrl'],
      coverLetterUrl: data['coverLetterUrl'],
      status: ApplicantApplicationStatus.values.byName(data['status']),
      appliedAt: data['appliedAt'],
      companyId: data['companyId'],
      matchScore: data['matchScore'],
      profileImageUrl: data['profileImageUrl'],
      quizRequired: data['quizRequired'],
      quizStatus: QuizStatus.values.byName(data['quizStatus']),
      attemptedQuizVersion: data['attemptedQuizVersion'],
      quizSubmission: data['quizSubmission'] != null
          ? QuizSubmission.fromMap(data['quizSubmission'])
          : null,
      quizScore: data['quizScore'],
      quizPassed: data['quizPassed'],
    );
  }


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'jobId': jobId,
    'fullName': fullName,
    'email': email,
    'resumeUrl': resumeUrl,
    'coverLetterUrl': coverLetterUrl,
    'status': status.name,
    'appliedAt': appliedAt,
    'profileImageUrl': profileImageUrl,
    'matchScore': matchScore,
    'companyId':companyId,
    'quizRequired': quizRequired,
    'quizStatus': quizStatus.name,
    'attemptedQuizVersion': attemptedQuizVersion,
    'quizScore': quizScore,
    'quizPassed': quizPassed,
    'quizSubmission': quizSubmission?.toMap(),
  };

  static ApplicantApplicationStatus _parseApplicationStatus(String status) {
    return ApplicantApplicationStatus.values.firstWhere(
          (e) => e.name == status,
      orElse: () => ApplicantApplicationStatus.pending,
    );
  }

  static QuizStatus _parseQuizStatus(String? status) {
    return QuizStatus.values.firstWhere(
          (e) => e.name == status,
      orElse: () => QuizStatus.notStarted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApplicantModel &&
        other.id == id &&
        other.jobId == jobId &&
        other.quizSubmission == quizSubmission;
  }

  @override
  int get hashCode => id.hashCode ^ jobId.hashCode ^ quizSubmission.hashCode;
}
