import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bc_tuto/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  ///Helper function to get full name.
  String get fullName => '$firstName $lastName';

  ///Helper function to format phone number.
  String get formatedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  ///Static function to split fullname and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  ///Static function to generat a username from the full name
  static String GenerateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName =
        '$firstName$lastName'; //combine forst and last name
    String usernameWithPrefix =
        'JIMP_$camelCaseUserName'; // add the Jimp prefix

    return usernameWithPrefix;
  }

  ///Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  ///Convert model to JSON structure data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

  ///Factory Method to crete a usermodel from firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return UserModel.fromSnapshot(document);
  }
}
