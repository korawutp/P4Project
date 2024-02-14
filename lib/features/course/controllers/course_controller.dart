import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
import 'package:workproject/features/course/models/course_model.dart';
import 'package:workproject/utils/permission_handler/permission_handler.dart';
import 'package:workproject/utils/popups/loaders.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final courseLoading = false.obs;
  final courseList = Rx<List<CourseModel>>([]);

  final duration = TextEditingController();
  final courseName = TextEditingController();
  final courseRepository = Get.put(CourseRepository());

  var courseStatuses = <String, RxString>{}.obs;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
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

  void attemptToAccessCourse(String courseId) async {
    Get.close(1);
    bool canAccess = await canAccessCourse(courseId);
    if (canAccess) {
      // อนุญาตให้เข้าถึงหรือเช็คชื่อ
      updateCourseStatus(courseId, 'Checked'); // อัปเดตสถานะเป็น 'Checked'
      MyAppLoader.successSnackBar(title: 'Success', message: 'Have a great day!');
    } else {
      MyAppLoader.errorSnackBar(
          title: 'Access Denied',
          message: "You must be connected to the same WiFi as the instructor to access this course.");
    }
  }

  Future<bool> canAccessCourse(String courseId) async {
    final info = NetworkInfo();
    final wifiSSID = await info.getWifiName(); // SSID ที่เชื่อมต่ออยู่
    final wifiSubmask = await info.getWifiSubmask(); // Submask

    final doc = await _db.collection('Courses').doc(courseId).get();

    if (doc.exists && wifiSSID != null && wifiSubmask != null) {
      final courseWifiSSID = doc.data()?['WifiSSID'];
      final courseWifiSubmask = doc.data()?['WifiSubmask'];
      return courseWifiSSID == wifiSSID && courseWifiSubmask == wifiSubmask;
    } else {
      MyAppLoader.errorSnackBar(
          title: 'Warning', message: "Cannot access WiFi data. Make sure you are connected to WiFi.");
      return false;
    }
  }

  Future<void> addCourse(String createdBy) async {
    final info = NetworkInfo();
    final wifiSSID = await info.getWifiName(); // SSID : MyWifi
    final wifiSubmask = await info.getWifiSubmask(); // Submask : 255.255.255.0

    if (wifiSSID == null || wifiSubmask == null) {
      MyAppLoader.errorSnackBar(
          title: 'Warning', message: "Cannot access WiFi data. Make sure you are connected to WiFi.");
      return;
    }

    await _db.collection('Courses').add({
      'CourseName': courseName.text.trim(),
      'WifiSSID': wifiSSID,
      'WifiSubmask': wifiSubmask,
      'CreatedAt': Timestamp.now(),
      'CreatedBy': createdBy,
    });
    Get.close(1);
    fetchCoursesList();
  }

  Future<void> printWifiInfo() async {
    final info = NetworkInfo();
    final wifiSSID = await info.getWifiName(); // SSID
    final wifiSubmask = await info.getWifiSubmask(); // Submask
    print(wifiSSID);
    print(wifiSubmask);
  }

  void updateCourseStatus(String id, String newStatus) {
    if (courseStatuses.containsKey(id)) {
      courseStatuses[id]!.value = newStatus;
    } else {
      courseStatuses[id] = RxString(newStatus);
    }
  }

  String getCourseStatus(String id) {
    return courseStatuses.containsKey(id) ? courseStatuses[id]!.value : 'Available';
  }
}
