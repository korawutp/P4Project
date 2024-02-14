import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/utils/formatters/formatter.dart';

/// Model class representing user data.
class UserModel {
  // Keep those values final which you do not update
  final String id;
  String firstName;
  String lastName;
  // final String userName;
  String studentID;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Contructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    // required this.userName,
    required this.studentID,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => MyAppFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from full name.
  // static String generateUsername(fullName) {
  //   List<String> nameParts = fullName.split(" ");
  //   String firstName = nameParts[0].toLowerCase();
  //   String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

  //   String camelCaseUsername = "$firstName$lastName"; // Combine first and last name.
  //   String usernameWithPrefix = "nu_$camelCaseUsername"; // Add "nu_" prefix
  //   return usernameWithPrefix;
  // }

  /// Static function to create an empty uesr model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      // userName: '',
      studentID: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      // 'Username': userName,
      'StudentID': studentID,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        // userName: data['Username'] ?? '',
        studentID: data['StudentID'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
