import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String id;
  final String courseName;
  final String wifiSSID;
  final String wifiSubmask;
  final DateTime createdAt;
  final String createdByID;
  final String createdByName;
  final String? classCode; // Optional field for class code
  final int durationMinutes;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.wifiSSID,
    required this.wifiSubmask,
    required this.createdAt,
    required this.createdByID,
    required this.createdByName,
    required this.durationMinutes,
    this.classCode, // Initialize as optional
  });

  static CourseModel empty() => CourseModel(
        id: '',
        courseName: '',
        wifiSSID: '',
        wifiSubmask: '',
        createdAt: DateTime.now(),
        createdByID: '',
        createdByName: '',
        classCode: null, // Default to null
        durationMinutes: 5,
      );

  Map<String, dynamic> toJson() {
    final json = {
      'CourseName': courseName,
      'WifiSSID': wifiSSID,
      'WifiSubmask': wifiSubmask,
      'CreatedAt': Timestamp.fromDate(createdAt),
      'CreatedByID': createdByID,
      'CreatedByName': createdByName,
      'Duration': durationMinutes,
    };

    if (classCode != null) {
      json['ClassCode'] = classCode!; // Add classCode if not null
    }

    return json;
  }

  factory CourseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CourseModel(
      id: document.id,
      courseName: data['CourseName'] ?? '',
      wifiSSID: data['WifiSSID'] ?? '',
      wifiSubmask: data['WifiSubmask'] ?? '',
      createdAt: (data['CreatedAt'] as Timestamp).toDate(),
      createdByID: data['CreatedByID'] ?? '',
      createdByName: data['CreatedByName'] ?? '',
      classCode: data['ClassCode'], // May be null
      durationMinutes: data['Duration'] ?? 5,
    );
  }

}
