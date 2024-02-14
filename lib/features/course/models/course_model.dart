import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing course data.
class CourseModel {
  final String id;
  final String courseName;
  final String wifiSubmask;
  final DateTime createdAt;
  final String createdBy;

  /// Contructor for CourseModel
  CourseModel({
    required this.id,
    required this.courseName,
    required this.wifiSubmask,
    required this.createdAt,
    required this.createdBy,
  });

  static CourseModel empty() => CourseModel(
        id: '',
        courseName: '',
        wifiSubmask: '',
        createdAt: DateTime.now(),
        createdBy: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'CourseName': courseName,
      'WifiSubmask': wifiSubmask,
      'CreatedAt': Timestamp.fromDate(createdAt),
      'CreatedBy': createdBy,
    };
  }

  factory CourseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CourseModel(
      id: document.id,
      courseName: data['CourseName'] ?? '',
      wifiSubmask: data['WifiSubmask'] ?? '',
      createdAt: (data['CreatedAt'] as Timestamp).toDate(), // แปลง Timestamp เป็น DateTime
      createdBy: data['CreatedBy'] ?? '',
    );
  }
}
