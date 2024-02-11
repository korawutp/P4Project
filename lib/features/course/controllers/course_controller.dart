import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
import 'package:workproject/features/course/models/course_model.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final courseLoading = false.obs;
  final courseList = Rx<List<CourseModel>>([]);

  final duration = TextEditingController();
  final courseName = TextEditingController();
  final courseRepository = Get.put(CourseRepository());

  @override
  void onInit() {
    super.onInit();
    fetchCoursesList();
  }

  /// Fetch user record
  Future<void> fetchCoursesList() async {
    courseLoading.value = true;
    try {
      final courses = await courseRepository.fetchCourseList();
      courseList.value = courses;
    } catch (e) {
      Get.snackbar("Error", "Cannot fetch courses: $e", snackPosition: SnackPosition.BOTTOM);
    } finally {
      courseLoading.value = false;
    }
  }

  Future<Map<String, String?>> getCurrentNetworkInfo() async {
    final info = NetworkInfo();
    var wifiBSSID = await info.getWifiBSSID();
    var wifiIP = await info.getWifiIP();
    return {'bssid': wifiBSSID, 'ip': wifiIP};
  }

  bool isIPInRange(String? ip, String rangePrefix) {
    // Simple check: This function needs to be adjusted based on your IP range checking logic
    return ip?.startsWith(rangePrefix) ?? false;
  }

  Future<void> addCourse(String createdBy) async {
    final info = NetworkInfo();
    final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
    final wifiIPv6 = await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    final wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1

    // ตรวจสอบค่า null
    if (wifiIP == null || wifiBSSID == null) {
      print('ไม่สามารถเข้าถึงข้อมูล WiFi ได้');
      return;
    }

    // บันทึกข้อมูลห้องเรียนพร้อมข้อมูล WiFi ลงใน Firestore
    await _db.collection('Courses').add({
      'CourseName': courseName.text.trim(),
      'WifiBSSID': wifiBSSID,
      'WifiIP': wifiIP,
      'WifiIPv6': wifiIPv6,
      'WifiSubmask': wifiSubmask,
      'WifiBroadcast': wifiBroadcast,
      'WifiGateway': wifiGateway,
      'CreatedAt': Timestamp.now(),
      'CreateBy': createdBy,
    });

    // หลังจากเพิ่มข้อมูลหลักสูตรใหม่ อาจต้องการเรียก fetchCourses อีกครั้งเพื่ออัปเดต UI
    fetchCoursesList();
  }
}
