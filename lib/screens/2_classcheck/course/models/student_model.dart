import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String id;
  final String studentName;
  final String studentID;
  final DateTime checkedInAt;

  StudentModel({
    required this.id,
    required this.studentName,
    required this.studentID,
    required this.checkedInAt,
  });

  static StudentModel empty() => StudentModel(
        id: '',
        studentName: '',
        studentID: '',
        checkedInAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    return {
      'StudentName': studentName,
      'StudentID': studentID,
      'CheckedInAt': Timestamp.fromDate(checkedInAt),
    };
  }

  factory StudentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
      id: document.id,
      studentName: data['StudentName'] ?? '',
      studentID: data['StudentID'] ?? '',
      checkedInAt: (data['CheckedInAt'] as Timestamp).toDate(),
    );
  }
}
