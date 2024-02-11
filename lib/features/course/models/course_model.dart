import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing course data.
class CourseModel {
  final String id;
  final String courseName;
  final String wifiBSSID;
  final String wifiIP;
  final String wifiIPv6;
  final String wifiSubmask;
  final String wifiBroadcast;
  final String wifiGateway;
  final DateTime createdAt;
  final String createdBy;

  /// Contructor for CourseModel
  CourseModel({
    required this.id,
    required this.courseName,
    required this.wifiBSSID,
    required this.wifiIP,
    required this.wifiIPv6,
    required this.wifiSubmask,
    required this.wifiBroadcast,
    required this.wifiGateway,
    required this.createdAt,
    required this.createdBy,
  });

  static CourseModel empty() => CourseModel(
        id: '',
        courseName: '',
        wifiBSSID: '',
        wifiIP: '',
        wifiIPv6: '',
        wifiSubmask: '',
        wifiBroadcast: '',
        wifiGateway: '',
        createdAt: DateTime.now(),
        createdBy: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'CourseName': courseName,
      'WifiBSSID': wifiBSSID,
      'WifiIP': wifiIP,
      'WifiIPv6': wifiIPv6,
      'WifiSubmask': wifiSubmask,
      'WifiBroadcast': wifiBroadcast,
      'WifiGateway': wifiGateway,
      'CreatedAt': Timestamp.fromDate(createdAt),
      'CreateBy': createdBy,
    };
  }

  factory CourseModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CourseModel(
      id: document.id,
      courseName: data['CourseName'] ?? '',
      wifiBSSID: data['WifiBSSID'] ?? '',
      wifiIP: data['WifiIP'] ?? '',
      wifiIPv6: data['WifiIPv6'] ?? '',
      wifiSubmask: data['WifiSubmask'] ?? '',
      wifiBroadcast: data['WifiBroadcast'] ?? '',
      wifiGateway: data['WifiGateway'] ?? '',
      createdAt: (data['CreatedAt'] as Timestamp).toDate(), // แปลง Timestamp เป็น DateTime
      createdBy: data['CreateBy'] ?? '',
    );
  }
}
