
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:project_bc_tuto/features/Applications/models/quizModel.dart';

/// Enums for application status and activity status.
enum ApplicationStatus { notApplied, applied, accepted, rejected }
enum ApplicationActivityStatus { active, expired }
enum VerificationStatus { pending, verified, rejected }

class PostingModel {
  final String id;
  final String companyId;
  final String companyLogo;
  final String companyName;
  final String opportunityType;
  final String jobTitle;
  final String jobDescription;
  final String location;
  final String employmentMode;
  final String experienceLevel;
  final String? salaryRange;
  final List<String> benefits;
  final String frequency;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime deadline;
  final String? requiredDocuments;
  final int? applicationQuota;
  final String? selectionProcess;

  final String workAuthorizationRequirements;
  final String contactEmail;
  final DateTime? expectedStartDate;
  final DateTime? postingExpirationDate;

  // Internship-specific fields
  final String? duration;
  final bool academicCredit;
  final bool returnOfferPotential;
  final String trainingProvided;
  final bool projectPortfolio;

  // Additional fields
  final String jobCategory;
  final List<String> subcategories;
  final String educationLevel;
  final String languageRequirements;
  final List<String> tags;
  final List<String> requiredSkills;
  final String preferredRequirements;
  final String minimumRequirements;
  final String additionalInfo;

  final QuizModel? verificationQuiz;
  final bool quizRequired;
  final int quizVersion;
  final DateTime? quizUpdatedAt;
  final int quizTimeLimit; // Minutes
  final bool quizProctored;
  final bool quizActive;

  final ApplicationStatus applicationStatus;
  final ApplicationActivityStatus activityStatus;
  final VerificationStatus verificationStatus;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  PostingModel({
    required this.id,
    required this.companyName,
    required this.companyId,
    required this.companyLogo,
    required this.opportunityType,
    required this.jobTitle,
    required this.jobDescription,
    required this.location,
    required this.employmentMode,
    required this.experienceLevel,
    this.salaryRange,
    List<String>? benefits,
    required this.frequency,
    this.startDate,
    this.endDate,
    required this.deadline,
    this.requiredDocuments,
    this.applicationQuota,
    this.selectionProcess,
    required this.workAuthorizationRequirements,
    required this.contactEmail,
    this.expectedStartDate,
    this.postingExpirationDate,
    // Internship fields:
    this.duration,
    this.academicCredit = false,
    this.returnOfferPotential = false,
    this.trainingProvided = '',
    this.projectPortfolio = false,
    // Additional fields:
    required this.jobCategory,
    List<String>? subcategories,
    required this.educationLevel,
    required this.languageRequirements,
    List<String>? tags,
    List<String>? requiredSkills,
    this.preferredRequirements = '',
    this.minimumRequirements = '',
    this.additionalInfo = '',
    this.verificationQuiz,
    this.quizRequired = false,
    this.quizVersion = 1,
    this.quizUpdatedAt,
    this.quizTimeLimit = 30,
    this.quizProctored = false,
    this.quizActive = true,
    // Application tracking:
    this.applicationStatus = ApplicationStatus.notApplied,
    this.activityStatus = ApplicationActivityStatus.active,
    this.verificationStatus = VerificationStatus.pending,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : benefits = benefits ?? <String>[],
        subcategories = subcategories ?? <String>[],
        tags = tags ?? <String>[],
        requiredSkills = requiredSkills ?? <String>[],
        createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now(),
        assert( !quizRequired || verificationQuiz != null, 'Cannot require quiz without providing verificationQuiz',),
        assert(quizTimeLimit >= 0,'Time limit cannot be negative',);



  /// Converts this PostingModel instance to a JSON map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'companyLogo': companyLogo,
    'companyName': companyName,
    'opportunityType': opportunityType,
    'jobTitle': jobTitle,
    'jobDescription': jobDescription,
    'location': location,
    'employmentMode': employmentMode,
    'experienceLevel': experienceLevel,
    'salaryRange': salaryRange,
    'benefits': benefits,
    'frequency': frequency,
    'startDate': startDate,
    'endDate': endDate,
    'deadline': deadline,
    'requiredDocuments': requiredDocuments,
    'applicationQuota': applicationQuota,
    'selectionProcess': selectionProcess,
    'workAuthorizationRequirements': workAuthorizationRequirements,
    'contactEmail': contactEmail,
    'expectedStartDate': expectedStartDate,
    'postingExpirationDate': postingExpirationDate,
    'duration': duration,
    'academicCredit': academicCredit,
    'returnOfferPotential': returnOfferPotential,
    'trainingProvided': trainingProvided,
    'projectPortfolio': projectPortfolio,
    'jobCategory': jobCategory,
    'subcategories': subcategories,
    'educationLevel': educationLevel,
    'languageRequirements': languageRequirements,
    'tags': tags,
    'requiredSkills': requiredSkills,
    'preferredRequirements': preferredRequirements,
    'minimumRequirements': minimumRequirements,
    'additionalInfo': additionalInfo,
    'verificationQuiz': verificationQuiz?.toJson(),
    'quizRequired': quizRequired,
    'quizVersion': quizVersion,
    'quizUpdatedAt': quizUpdatedAt,
    'quizTimeLimit': quizTimeLimit,
    'quizProctored': quizProctored,
    'quizActive': quizActive,
    'applicationStatus': applicationStatus.name,
    'activityStatus': activityStatus.name,
    'verificationStatus': verificationStatus.name,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  /// Creates a PostingModel from a JSON map.
  factory PostingModel.fromJson(Map<String, dynamic> json) {
    // Utility function to parse a field that should be a List<String>
    List<String> parseStringList(dynamic field) {
      if (field == null) return [];
      if (field is String) return [field];
      if (field is Iterable) return List<String>.from(field);
      return [];
    }

    return PostingModel(
        id: json['id'] ?? '',
        companyLogo: json['companyLogo'] ?? '',
        companyName: json['companyName'] ?? '',
        companyId: json['companyId'] ?? '',
        opportunityType: json['opportunityType'] ?? '',
        jobTitle: json['jobTitle'] ?? '',
        jobDescription: json['jobDescription'] ?? '',
        workAuthorizationRequirements: json['workAuthorizationRequirements'] ?? '',
        contactEmail: json['contactEmail'] ?? '',
        location: json['location'] ?? '',
        employmentMode: json['employmentMode'] ?? '',
        experienceLevel: json['experienceLevel'] ?? '',
        salaryRange: json['salaryRange'], // optional string field
        benefits: parseStringList(json['benefits']),
        frequency: json['frequency'] ?? '',
        duration: json['duration'] ?? '',
        startDate: json['startDate'] is Timestamp
            ? (json['startDate'] as Timestamp).toDate()
            : null,
        endDate: json['endDate'] is Timestamp
            ? (json['endDate'] as Timestamp).toDate()
            : null,
        deadline: json['deadline'] is Timestamp
            ? (json['deadline'] as Timestamp).toDate()
            : DateTime.now(),
        requiredDocuments: json['requiredDocuments'],
        applicationQuota: json['applicationQuota'],
        selectionProcess: json['selectionProcess'],
      subcategories: parseStringList(json['subcategories']),
      jobCategory: json['jobCategory'] ?? '',
      educationLevel: json['educationLevel'] ?? '',
      languageRequirements: json['languageRequirements'] ?? '',
      tags: parseStringList(json['tags']),
      requiredSkills: parseStringList(json['requiredSkills']),
      preferredRequirements: json['preferredRequirements'] ?? '',
      minimumRequirements: json['minimumRequirements'] ?? '',
      additionalInfo: json['additionalInfo'] ?? '',
      quizRequired: json['quizRequired'] ?? false,
      quizVersion: json['quizVersion'] ?? 1,
      quizUpdatedAt: json['quizUpdatedAt']?.toDate(),
      quizTimeLimit: json['quizTimeLimit'] ?? 30,
      quizProctored: json['quizProctored'] ?? false,
      quizActive: json['quizActive'] ?? true,
      verificationQuiz: json['verificationQuiz'] != null
          ? QuizModel.fromJson(json['verificationQuiz'])
          : null,

      applicationStatus: ApplicationStatus.values.firstWhere(
            (e) => e.name.toLowerCase() ==
            (json['applicationStatus'] ?? 'notApplied').toString().toLowerCase(),
        orElse: () => ApplicationStatus.notApplied,
      ),
      activityStatus: ApplicationActivityStatus.values.firstWhere(
            (e) => e.name.toLowerCase() ==
            (json['activityStatus'] ?? 'active').toString().toLowerCase(),
        orElse: () => ApplicationActivityStatus.active,
      ),
      verificationStatus: VerificationStatus.values.firstWhere(
            (e) => e.name.toLowerCase() ==
            (json['verificationStatus'] ?? 'pending').toString().toLowerCase(),
        orElse: () => VerificationStatus.pending,
      ),
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt']
          : Timestamp.now(),
      updatedAt: json['updatedAt'] is Timestamp
          ? json['updatedAt']
          : Timestamp.now(),

    );
  }

  /// Creates a PostingModel from a Firestore document snapshot.
  factory PostingModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Document data is null for ID: ${doc.id}");
    }
    return PostingModel.fromJson({...data, 'id': doc.id});
  }

  /// Creates a copy of the current PostingModel with overridden fields.
  PostingModel copyWith({
    String? id,
    String? companyId,
    String? companyLogo,
    String? companyName,
    String? opportunityType,
    String? jobTitle,
    String? jobDescription,
    String? location,
    String? employmentMode,
    String? experienceLevel,
    String? salaryRange,
    List<String>? benefits,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? deadline,
    String? requiredDocuments,
    int? applicationQuota,
    String? selectionProcess,
    String? workAuthorizationRequirements,
    String? contactEmail,
    DateTime? expectedStartDate,
    DateTime? postingExpirationDate,
    String? duration,
    bool? academicCredit,
    bool? returnOfferPotential,
    String? trainingProvided,
    bool? projectPortfolio,
    String? jobCategory,
    List<String>? subcategories,
    String? educationLevel,
    String? languageRequirements,
    List<String>? tags,
    List<String>? requiredSkills,
    String? preferredRequirements,
    String? minimumRequirements,
    String? additionalInfo,
    ApplicationStatus? applicationStatus,
    ApplicationActivityStatus? activityStatus,
    VerificationStatus? verificationStatus,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return PostingModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      companyLogo: companyLogo ?? this.companyLogo,
      companyName: companyName ?? this.companyName,
      opportunityType: opportunityType ?? this.opportunityType,
      jobTitle: jobTitle ?? this.jobTitle,
      jobDescription: jobDescription ?? this.jobDescription,
      location: location ?? this.location,
      employmentMode: employmentMode ?? this.employmentMode,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      salaryRange: salaryRange ?? this.salaryRange,
      benefits: benefits ?? this.benefits,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deadline: deadline ?? this.deadline,
      requiredDocuments: requiredDocuments ?? this.requiredDocuments,
      applicationQuota: applicationQuota ?? this.applicationQuota,
      selectionProcess: selectionProcess ?? this.selectionProcess,
      workAuthorizationRequirements:
      workAuthorizationRequirements ?? this.workAuthorizationRequirements,
      contactEmail: contactEmail ?? this.contactEmail,
      expectedStartDate: expectedStartDate ?? this.expectedStartDate,
      postingExpirationDate:
      postingExpirationDate ?? this.postingExpirationDate,
      duration: duration ?? this.duration,
      academicCredit: academicCredit ?? this.academicCredit,
      returnOfferPotential: returnOfferPotential ?? this.returnOfferPotential,
      trainingProvided: trainingProvided ?? this.trainingProvided,
      projectPortfolio: projectPortfolio ?? this.projectPortfolio,
      jobCategory: jobCategory ?? this.jobCategory,
      subcategories: subcategories ?? this.subcategories,
      educationLevel: educationLevel ?? this.educationLevel,
      languageRequirements: languageRequirements ?? this.languageRequirements,
      tags: tags ?? this.tags,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      preferredRequirements: preferredRequirements ?? this.preferredRequirements,
      minimumRequirements: minimumRequirements ?? this.minimumRequirements,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      applicationStatus: applicationStatus ?? this.applicationStatus,
      activityStatus: activityStatus ?? this.activityStatus,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}