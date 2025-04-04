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

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String password;
  String country;
  String region;
  String city;
  String localAddress;
  String educationLevel;
  String schoolAttended;

  // Optional fields
  String profilePicture;
  List<SkillEntry> skills;
  String selfDescription;
  String jobTypePreference;
  List<LanguageEntry> languages;
  List<String> hobbies;
  String resume;
  String linkedin;
  String github;
  String portfolio;
  String opportunityType;
  String jobCategory;

  String userType;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.country,
    required this.region,
    required this.city,
    required this.localAddress,
    required this.educationLevel,
    required this.schoolAttended,
    // Optional fields with default values
    this.profilePicture = '',
    this.skills = const [],
    this.selfDescription = '',
    this.jobTypePreference = '',
    this.languages = const [],
    this.hobbies = const [],
    this.resume = '',
    this.linkedin = '',
    this.github = '',
    this.portfolio = '',
    this.opportunityType = '',
    this.jobCategory = '',
    this.userType = 'candidate',
    Timestamp? createdAt,
    Timestamp? updatedAt,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  /// Helper function to get full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formatedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from full name.
  static String GenerateUsername(fullName) {
    List<String> parts = fullName.split(" ");
    String firstName = parts.isNotEmpty ? parts[0].toLowerCase() : '';
    String lastName = parts.length > 1 ? parts[1].toLowerCase() : '';
    return '${firstName + lastName}';
  }

  /// Creates a copy of the current UserModel with the given fields replaced.
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? password,
    String? country,
    String? region,
    String? city,
    String? localAddress,
    String? educationLevel,
    String? schoolAttended,
    String? profilePicture,
    List<SkillEntry>? skills,
    String? selfDescription,
    String? jobTypePreference,
    List<LanguageEntry>? languages,
    List<String>? hobbies,
    String? resume,
    String? linkedin,
    String? github,
    String? portfolio,
    String? opportunityType,
    String? jobCategory,
    String? userType,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    final updatedFirst = firstName ?? this.firstName;
    final updatedLast = lastName ?? this.lastName;
    // Regenerate username if either firstName or lastName is updated.
    final updatedUsername = (firstName != null || lastName != null)
        ? UserModel.GenerateUsername("$updatedFirst $updatedLast")
        : this.username;

    return UserModel(
      id: id ?? this.id,
      firstName: updatedFirst,
      lastName: updatedLast,
      username: username ?? updatedUsername,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      country: country ?? this.country,
      region: region ?? this.region,
      city: city ?? this.city,
      localAddress: localAddress ?? this.localAddress,
      educationLevel: educationLevel ?? this.educationLevel,
      schoolAttended: schoolAttended ?? this.schoolAttended,
      profilePicture: profilePicture ?? this.profilePicture,
      skills: skills ?? this.skills,
      selfDescription: selfDescription ?? this.selfDescription,
      jobTypePreference: jobTypePreference ?? this.jobTypePreference,
      languages: languages ?? this.languages,
      hobbies: hobbies ?? this.hobbies,
      resume: resume ?? this.resume,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      portfolio: portfolio ?? this.portfolio,
      opportunityType: opportunityType ?? this.opportunityType,
      jobCategory: jobCategory ?? this.jobCategory,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Convert this model to a JSON map for Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
      'ProfilePicture': profilePicture,
      'Country': country,
      'Region': region,
      'City': city,
      'LocalAddress': localAddress,
      'EducationLevel': educationLevel,
      'SchoolAttended': schoolAttended,
      'Skills': skills.map((skill) => skill.toJson()).toList(),
      'SelfDescription': selfDescription,
      'JobTypePreference': jobTypePreference,
      'Languages': languages.map((lang) => lang.toJson()).toList(),
      'Hobbies': hobbies,
      'Resume': resume,
      'Linkedin': linkedin,
      'Github': github,
      'Portfolio': portfolio,
      'OpportunityType': opportunityType,
      'JobCategory': jobCategory,
      'UserType': userType,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  /// Create a [UserModel] from a Firestore document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      username: data['Username'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      password: data['Password'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      country: data['Country'] ?? '',
      region: data['Region'] ?? '',
      city: data['City'] ?? '',
      localAddress: data['LocalAddress'] ?? '',
      educationLevel: data['EducationLevel'] ?? '',
      schoolAttended: data['SchoolAttended'] ?? '',
      skills: data['Skills'] != null
          ? List<SkillEntry>.from(
              (data['Skills'] as List).map((x) => SkillEntry.fromJson(x)))
          : [],
      selfDescription: data['SelfDescription'] ?? '',
      jobTypePreference: data['JobTypePreference'] ?? '',
      languages: data['Languages'] != null
          ? List<LanguageEntry>.from(
              (data['Languages'] as List).map((x) => LanguageEntry.fromJson(x)))
          : [],
      hobbies: List<String>.from(data['Hobbies'] ?? []),
      resume: data['Resume'] ?? '',
      linkedin: data['Linkedin'] ?? '',
      github: data['Github'] ?? '',
      portfolio: data['Portfolio'] ?? '',
      opportunityType: data['OpportunityType'] ?? '',
      jobCategory: data['JobCategory'] ?? '',
      userType: data['UserType'] ?? 'candidate',
      createdAt: data['CreatedAt'] ?? Timestamp.now(),
      updatedAt: data['UpdatedAt'] ?? Timestamp.now(),
    );
  }

  /// Create an empty [UserModel] (for initialization).
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        password: '',
        country: '',
        region: '',
        city: '',
        localAddress: '',
        educationLevel: '',
        schoolAttended: '',
      );
}
