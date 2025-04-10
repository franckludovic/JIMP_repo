import 'package:cloud_firestore/cloud_firestore.dart';

/// An enum for verification status (if needed for postings).
enum VerificationStatus { pending, verified, rejected }

/// A simple address model (shared if needed in posting, e.g. for job location).
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

  /// The company ID creating this posting (can be auto-filled from company profile).
  final String companyId;

  /// Opportunity type: "Job", "Internship", or "Contract"
  final String opportunityType;

  /// Job/Position title.
  final String jobTitle;

  /// Opportunity description.
  final String jobDescription;

  /// Location name/address (can be free-form).
  final String location;

  /// Employment type: e.g., "Remote", "Onsite", "Hybrid"
  final String employmentType;

  /// Experience level: e.g., "Entry Level", "Mid Level", "High Level"
  final String experienceLevel;

  /// Salary details – For Job/Contract; for Internship, you may use a stipend.
  final String? salaryRange;

  /// Benefits and perks information (optional).
  final String? benefits;

  /// Time frame for the opportunity, such as start and end dates.
  final DateTime? startDate;
  final DateTime? endDate;

  /// Application deadline.
  final DateTime deadline;

  /// Application process details
  final String howToApply;
  final String? requiredDocuments;
  final int? applicationQuota;
  final String? selectionProcess;


  final String aboutCompany;
  final String? teamDepartment;


  final String? equalOpportunityStatement;
  final String? workAuthorizationRequirements;
  final DateTime? expectedStartDate;
  final DateTime? postingExpirationDate;
  final String? internalReferenceCode;
  final String? contactEmail;

  /// Internship-specific fields (optional; only used when opportunityType is "Internship")
  final String? duration; // e.g., "3 months", "6 months"
  final bool? academicCredit; // Available or not
  final bool? returnOfferPotential; // Yes or No
  final String? trainingProvided; // e.g., "Technical Workshops", "Soft Skills Training", etc.
  final bool? projectPortfolio; // Will measurable projects be built?

  /// Metadata
  final VerificationStatus verificationStatus;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  PostingModel({
    required this.id,
    required this.companyId,
    required this.opportunityType,
    required this.jobTitle,
    required this.jobDescription,
    required this.location,
    required this.employmentType,
    required this.experienceLevel,
    this.salaryRange,
    this.benefits,
    this.startDate,
    this.endDate,
    required this.deadline,
    required this.howToApply,
    this.requiredDocuments,
    this.applicationQuota,
    this.selectionProcess,
    required this.aboutCompany,
    this.teamDepartment,
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

  /// Converts the PostingModel instance to JSON.
  Map<String, dynamic> toJson() => {
    'id': id,
    'companyId': companyId,
    'opportunityType': opportunityType,
    'jobTitle': jobTitle,
    'jobDescription': jobDescription,
    'location': location,
    'employmentType': employmentType,
    'experienceLevel': experienceLevel,
    'salaryRange': salaryRange,
    'benefits': benefits,
    'startDate': startDate,
    'endDate': endDate,
    'deadline': deadline,
    'howToApply': howToApply,
    'requiredDocuments': requiredDocuments,
    'applicationQuota': applicationQuota,
    'selectionProcess': selectionProcess,
    'aboutCompany': aboutCompany,
    'teamDepartment': teamDepartment,
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

  /// Creates a PostingModel from JSON.
  factory PostingModel.fromJson(Map<String, dynamic> json) {
    return PostingModel(
      id: json['id'] ?? '',
      companyId: json['companyId'] ?? '',
      opportunityType: json['opportunityType'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      jobDescription: json['jobDescription'] ?? '',
      location: json['location'] ?? '',
      employmentType: json['employmentType'] ?? '',
      experienceLevel: json['experienceLevel'] ?? '',
      salaryRange: json['salaryRange'],
      benefits: json['benefits'],
      startDate: json['startDate'] is Timestamp ? (json['startDate'] as Timestamp).toDate() : null,
      endDate: json['endDate'] is Timestamp ? (json['endDate'] as Timestamp).toDate() : null,
      deadline: json['deadline'] is Timestamp ? (json['deadline'] as Timestamp).toDate() : DateTime.now(),
      howToApply: json['howToApply'] ?? '',
      requiredDocuments: json['requiredDocuments'],
      applicationQuota: json['applicationQuota'],
      selectionProcess: json['selectionProcess'],
      aboutCompany: json['aboutCompany'] ?? '',
      teamDepartment: json['teamDepartment'],
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
