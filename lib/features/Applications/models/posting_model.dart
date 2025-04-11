import 'package:cloud_firestore/cloud_firestore.dart';

/// An enum for verification status (if needed for postings).
enum VerificationStatus { pending, verified, rejected }

/// A simple address model (shared for job location).
class Address {
  final String street;
  final String city;
  final String country;
  final String region;
  final String postalCode;

  Address({
    required this.street,
    required this.city,
    required this.country,
    required this.region,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'] ?? '',
    city: json['city'] ?? '',
    country: json['country'] ?? '',
    region: json['region'] ?? '',
    postalCode: json['postalCode'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'country': country,
    'region': region,
    'postalCode': postalCode,
  };
}

/// PostingModel represents a job/internship/contract posting by a company.
class PostingModel {
  /// Unique identifier for the posting.
  final String id;

  /// The company ID creating this posting.
  final String companyId;

  /// Opportunity type: "Job", "Internship", or "Contract"
  final String opportunityType;

  /// Job/Position title.
  final String jobTitle;

  /// Opportunity description.
  final String jobDescription;

  /// Location (free-form address or location name).
  final String location;

  /// Employment mode: "Remote", "Onsite", or "Hybrid"
  final String employmentMode;

  final String? jobCategory;
  final List<String> subcategories;
  final String? timeFrame;
  final String? educationLevel;
  final String? languageRequirements;


  /// Experience level: e.g., "Entry Level", "Mid Level", "High Level"
  final String experienceLevel;

  /// Salary details: For jobs/contracts (stipend for internships).
  final String? salaryRange;

  /// Benefits and perks information (optional).
  final String? benefits;

  /// Time frame for the opportunity – start and end dates (if applicable).
  final DateTime? startDate;
  final DateTime? endDate;

  /// Application deadline.
  final DateTime deadline;

  /// Application process details.
  final String howToApply;
  final String? requiredDocuments;
  final int? applicationQuota;
  final String? selectionProcess;


  /// Additional posting info (optional but recommended).
  final String? equalOpportunityStatement;
  final String? workAuthorizationRequirements;
  final DateTime? expectedStartDate;
  final DateTime? postingExpirationDate;
  final String? internalReferenceCode;
  final String? contactEmail;

  /// Internship-specific fields (optional; only applicable for internships).
  final String? duration; // e.g., "3 months", "6 months"
  final bool? academicCredit;
  final bool? returnOfferPotential;
  final String? trainingProvided;
  final bool? projectPortfolio;

  /// New field: Employment mode is already added above.

  /// Metadata
  final VerificationStatus verificationStatus;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  PostingModel({
    required this.id,
    required this.subcategories,
    required this.companyId,
    required this.opportunityType,
    required this.jobTitle,
    required this.jobDescription,
    required this.location,
    required this.employmentMode,
    required this.experienceLevel,
    this.salaryRange,
    this.jobCategory,
    this.timeFrame,
    this.educationLevel,
    this.languageRequirements,
    this.benefits,
    this.startDate,
    this.endDate,
    required this.deadline,
    required this.howToApply,
    this.requiredDocuments,
    this.applicationQuota,
    this.selectionProcess,
    this.equalOpportunityStatement,
    this.workAuthorizationRequirements,
    this.expectedStartDate,
    this.postingExpirationDate,
    this.internalReferenceCode,
    this.contactEmail,
    this.duration,
    this.academicCredit,
    this.returnOfferPotential,
    this.trainingProvided,
    this.projectPortfolio,
    this.verificationStatus = VerificationStatus.pending,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  /// Converts this PostingModel instance to a JSON map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'opportunityType': opportunityType,
    'jobTitle': jobTitle,
    'jobDescription': jobDescription,
    'location': location,
    'employmentMode': employmentMode,
    'experienceLevel': experienceLevel,
    'salaryRange': salaryRange,
    'benefits': benefits,
    'startDate': startDate,
    'endDate': endDate,
    'deadline': deadline,
    'jobCategory': jobCategory,
    'subCategory':subcategories,
    'timeFrame': timeFrame,
    'educationLevel': educationLevel,
    'languageRequirements': languageRequirements,
    'howToApply': howToApply,
    'requiredDocuments': requiredDocuments,
    'applicationQuota': applicationQuota,
    'selectionProcess': selectionProcess,
    'equalOpportunityStatement': equalOpportunityStatement,
    'workAuthorizationRequirements': workAuthorizationRequirements,
    'expectedStartDate': expectedStartDate,
    'postingExpirationDate': postingExpirationDate,
    'internalReferenceCode': internalReferenceCode,
    'contactEmail': contactEmail,
    'duration': duration,
    'academicCredit': academicCredit,
    'returnOfferPotential': returnOfferPotential,
    'trainingProvided': trainingProvided,
    'projectPortfolio': projectPortfolio,
    'verificationStatus': verificationStatus.name,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  /// Creates a PostingModel from a JSON map.
  factory PostingModel.fromJson(Map<String, dynamic> json) {
    return PostingModel(
      id: json['id'] ?? '',
      companyId: json['companyId'] ?? '',
      opportunityType: json['opportunityType'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      jobDescription: json['jobDescription'] ?? '',
      location: json['location'] ?? '',
      employmentMode: json['employmentMode'] ?? '',
      experienceLevel: json['experienceLevel'] ?? '',
      salaryRange: json['salaryRange'],
      benefits: json['benefits'],
      jobCategory: json['jobCategory'],
      timeFrame: json['timeFrame'],
      educationLevel: json['educationLevel'],
      languageRequirements: json['languageRequirements'],
      startDate: json['startDate'] is Timestamp ? (json['startDate'] as Timestamp).toDate() : null,
      endDate: json['endDate'] is Timestamp ? (json['endDate'] as Timestamp).toDate() : null,
      deadline: json['deadline'] is Timestamp ? (json['deadline'] as Timestamp).toDate() : DateTime.now(),
      howToApply: json['howToApply'] ?? '',
      requiredDocuments: json['requiredDocuments'],
      applicationQuota: json['applicationQuota'],
      selectionProcess: json['selectionProcess'],
      subcategories: List<String>.from(json['subCategory'] ?? []),
      equalOpportunityStatement: json['equalOpportunityStatement'],
      workAuthorizationRequirements: json['workAuthorizationRequirements'],
      expectedStartDate: json['expectedStartDate'] is Timestamp ? (json['expectedStartDate'] as Timestamp).toDate() : null,
      postingExpirationDate: json['postingExpirationDate'] is Timestamp ? (json['postingExpirationDate'] as Timestamp).toDate() : null,
      internalReferenceCode: json['internalReferenceCode'],
      contactEmail: json['contactEmail'],
      duration: json['duration'],
      academicCredit: json['academicCredit'],
      returnOfferPotential: json['returnOfferPotential'],
      trainingProvided: json['trainingProvided'],
      projectPortfolio: json['projectPortfolio'],
      verificationStatus: VerificationStatus.values.firstWhere(
            (e) => e.name.toLowerCase() ==
            (json['verificationStatus'] ?? 'pending').toString().toLowerCase(),
        orElse: () => VerificationStatus.pending,
      ),
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
}
