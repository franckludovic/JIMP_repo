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

  // Required fields
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

  UserModel({
    required this.id,
    // Required fields
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
  });

  /// Helper function to get full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formatedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split fullname into name parts.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String GenerateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUserName = '$firstName$lastName';
    return 'JIMP_$camelCaseUserName';
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
    };
  }

  /// Create a [UserModel] from a Firestore document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
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
