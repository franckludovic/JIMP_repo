import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../utils/formatters/formatter.dart';

class LanguageEntry {
  String language;
  int proficiency;

  LanguageEntry({
    required this.language,
    required this.proficiency,
  });

  Map<String, dynamic> toJson() {
    return {
      'Language': language,
      'Proficiency': proficiency,
    };
  }

  factory LanguageEntry.fromJson(Map<String, dynamic> json) {
    return LanguageEntry(
      language: json['Language'] ?? '',
      proficiency: json['Proficiency'] ?? 1,
    );
  }
}

class SkillEntry {
  String skill;
  int level;

  SkillEntry({
    required this.skill,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      'Skill': skill,
      'Level': level,
    };
  }

  factory SkillEntry.fromJson(Map<String, dynamic> json) {
    return SkillEntry(
      skill: json['Skill'] ?? '',
      level: json['Level'] ?? 1,
    );
  }
}

enum VerificationStatus { pending, verified, rejected }

class CompanyAddress {
  final String street;
  final String city;
  final String country;
  final String region;
  final String postalCode;

  CompanyAddress({
    required this.street,
    required this.city,
    required this.country,
    required this.region,
    required this.postalCode,
  });

  factory CompanyAddress.fromJson(Map<String, dynamic> json) => CompanyAddress(
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

class CompanyBranch {
  final CompanyAddress address;
  final String contactEmail;
  final String phoneNumber;
  final String contactName;

  CompanyBranch({
    required this.address,
    required this.contactEmail,
    required this.phoneNumber,
    required this.contactName,
  });

  factory CompanyBranch.fromJson(Map<String, dynamic> json) => CompanyBranch(
    address: CompanyAddress.fromJson(json['address'] ?? {}),
    contactEmail: json['contactEmail'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    contactName: json['contactName'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'address': address.toJson(),
    'contactEmail': contactEmail,
    'contactName': contactName,
    'phoneNumber': phoneNumber,
  };
}

class HRContact {
  final String name;
  final String title;
  final String email;
  final String phone;

  HRContact({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
  });

  factory HRContact.fromJson(Map<String, dynamic> json) => HRContact(
    name: json['name'] ?? '',
    title: json['title'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'email': email,
    'phone': phone,
  };
}

class CompanyModel {
  final String id;
  final String userType;
  String companyName;
  String size;
  final CompanyAddress headquarters;
  String industry;
  String registrationNumber;
  String businessLicenseUrl;
  String password;
  final Set<String> opportunityTypes;
  String opportunityCategory;
  final HRContact hrContact;
  final List<CompanyBranch> branches;
  String officialEmail;
  String phoneNumber1;
  String phoneNumber2;
  String description;
  final VerificationStatus verificationStatus;
  String website;
  String linkedinProfile;
  String logoUrl;
  String profileUrl;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final double mlMatchScore;
  final double aiRelevanceScore;
  final int totalListings;
  final double averageRating;
  final int ratingCount;

  CompanyModel({
    this.userType = 'Company',
    required this.id,
    required this.companyName,
    required this.size,
    required this.headquarters,
    required this.industry,
    required this.registrationNumber,
    required this.businessLicenseUrl,
    required this.password,
    required this.opportunityTypes,
    required this.opportunityCategory,
    required this.hrContact,
    required this.branches,
    required this.officialEmail,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.description,
    required this.verificationStatus,
    required this.website,
    required this.linkedinProfile,
    required this.logoUrl,
    required this.profileUrl,
    required this.mlMatchScore,
    this.aiRelevanceScore = 0.0,
    this.totalListings = 0,
    this.averageRating = 0.0,
    this.ratingCount = 0,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  /// Returns the full name by combining firstName and lastName.
  String get fullName => companyName; // Adjust this if you want a different combination

  /// Converts the model to JSON.
  Map<String, dynamic> toJson() => {
    'id': id,
    'userType': userType,
    'companyName': companyName,
    'size': size,
    'headquarters': headquarters.toJson(),
    'industry': industry,
    'registrationNumber': registrationNumber,
    'businessLicenseUrl': businessLicenseUrl,
    'password': password,
    'opportunityTypes': opportunityTypes.toList(),
    'opportunityCategory': opportunityCategory,
    'hrContact': hrContact.toJson(),
    'branches': branches.map((e) => e.toJson()).toList(),
    'officialEmail': officialEmail,
    'phoneNumber1': phoneNumber1,
    'phoneNumber2': phoneNumber2,
    'description': description,
    // Modification: Use the current instance's verificationStatus rather than always pending.
    'verificationStatus': verificationStatus.name, // Changed from VerificationStatus.pending.name
    'website': website,
    'linkedinProfile': linkedinProfile,
    'logoUrl': logoUrl,
    'profileUrl': profileUrl,
    'mlMatchScore': mlMatchScore,
    'aiRelevanceScore': aiRelevanceScore,
    'totalListings': totalListings,
    'averageRating': averageRating,
    'ratingCount': ratingCount,
    'CreatedAt': createdAt,
    'UpdatedAt': updatedAt,
  };

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? '',
      companyName: json['companyName'] ?? '',
      size: json['size'] ?? '',
      headquarters: CompanyAddress.fromJson(json['headquarters'] ?? {}),
      industry: json['industry'] ?? '',
      registrationNumber: json['registrationNumber'] ?? '',
      businessLicenseUrl: json['businessLicenseUrl'] ?? '',
      password: json['password'] ?? '',
      opportunityTypes: Set<String>.from(json['opportunityTypes'] ?? []),
      opportunityCategory: json['opportunityCategory'] ?? '',
      hrContact: HRContact.fromJson(json['hrContact'] ?? {}),
      branches: (json['branches'] as List<dynamic>?)
          ?.map((e) => CompanyBranch.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      officialEmail: json['officialEmail'] ?? '',
      phoneNumber1: json['phoneNumber1'] ?? '',
      phoneNumber2: json['phoneNumber2'] ?? '',
      description: json['description'] ?? '',
      verificationStatus: VerificationStatus.values.firstWhere(
            (e) => e.name == (json['verificationStatus'] ?? 'pending'),
        orElse: () => VerificationStatus.pending,
      ),
      website: json['website'] ?? '',
      linkedinProfile: json['linkedinProfile'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      mlMatchScore: (json['mlMatchScore'] as num?)?.toDouble() ?? 0.0,
      aiRelevanceScore: (json['aiRelevanceScore'] as num?)?.toDouble() ?? 0.0,
      totalListings: json['totalListings'] ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: json['ratingCount'] ?? 0,
      createdAt: json['CreatedAt'] is Timestamp
          ? json['CreatedAt']
          : Timestamp.now(),
      updatedAt: json['UpdatedAt'] is Timestamp
          ? json['UpdatedAt']
          : Timestamp.now(),
    );
  }

  /// Creates a UserModel from a Firestore document snapshot.
  factory CompanyModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Document data is null for ID: ${doc.id}");
    }
    return CompanyModel.fromJson({...data, 'id': doc.id});
  }

  /// Creates an empty instance of UserModel.
  static CompanyModel empty() => CompanyModel(
    id: '',
    userType: 'Company',
    companyName: '',
    size: '',
    headquarters: CompanyAddress(
      street: '',
      city: '',
      country: '',
      region: '',
      postalCode: '',
    ),
    industry: '',
    registrationNumber: '',
    businessLicenseUrl: '',
    password: '',
    opportunityTypes: {},
    opportunityCategory: '',
    hrContact: HRContact(name: '', title: '', email: '', phone: ''),
    branches: [],
    officialEmail: '',
    phoneNumber1: '',
    phoneNumber2: '',
    description: '',
    verificationStatus: VerificationStatus.pending,
    website: '',
    linkedinProfile: '',
    logoUrl: '',
    profileUrl: '',
    mlMatchScore: 0.0,
    aiRelevanceScore: 0.0,
    totalListings: 0,
    averageRating: 0.0,
    ratingCount: 0,
  );

// Added copyWith method to update fields in a new instance.
  CompanyModel copyWith({
    String? id,
    String? companyName,
    String? size,
    CompanyAddress? headquarters,
    String? industry,
    String? registrationNumber,
    String? businessLicenseUrl,
    String? password,
    Set<String>? opportunityTypes,
    String? opportunityCategory,
    HRContact? hrContact,
    List<CompanyBranch>? branches,
    String? officialEmail,
    String? phoneNumber1,
    String? phoneNumber2,
    String? description,
    VerificationStatus? verificationStatus,
    String? website,
    String? linkedinProfile,
    String? logoUrl,
    String? profileUrl,
    double? mlMatchScore,
    double? aiRelevanceScore,
    int? totalListings,
    double? averageRating,
    int? ratingCount,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      userType: userType, // userType is not expected to change in copyWith.
      companyName: companyName ?? this.companyName,
      size: size ?? this.size,
      headquarters: headquarters ?? this.headquarters,
      industry: industry ?? this.industry,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      businessLicenseUrl: businessLicenseUrl ?? this.businessLicenseUrl,
      password: password ?? this.password,
      opportunityTypes: opportunityTypes ?? this.opportunityTypes,
      opportunityCategory: opportunityCategory ?? this.opportunityCategory,
      hrContact: hrContact ?? this.hrContact,
      branches: branches ?? this.branches,
      officialEmail: officialEmail ?? this.officialEmail,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      description: description ?? this.description,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      website: website ?? this.website,
      linkedinProfile: linkedinProfile ?? this.linkedinProfile,
      logoUrl: logoUrl ?? this.logoUrl,
      profileUrl: profileUrl ?? this.profileUrl,
      mlMatchScore: mlMatchScore ?? this.mlMatchScore,
      aiRelevanceScore: aiRelevanceScore ?? this.aiRelevanceScore,
      totalListings: totalListings ?? this.totalListings,
      averageRating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}