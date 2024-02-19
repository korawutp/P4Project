import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/permission_handler/permission_handler.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final controller = Get.put(UserController());

  final courseLoading = false.obs;
  final courseList = Rx<List<CourseModel>>([]);

  final duration = TextEditingController();
  final courseName = TextEditingController();
  final courseRepository = Get.put(CourseRepository());
  GlobalKey<FormState> courseAddFormKey = GlobalKey<FormState>();

  var courseStatuses = <String, RxString>{}.obs;

  final isClassCodeEnabled = false.obs;
  final classCode = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
    fetchCoursesList();
  }

  /// Fetch course record
  Future<void> fetchCoursesList() async {
    courseLoading.value = true;
    try {
      final courses = await courseRepository.fetchCourseList(); // Ensure this is returning List<Course> or similar
      for (var course in courses) {
        await getStudentCheckedStatus(course.id); // Assuming each course has an 'id' field
      }
      courseList.value = courses;
    } catch (e) {
      MyAppLoader.errorSnackBar(title: 'Error', message: "Cannot fetch courses: $e");
    } finally {
      courseLoading.value = false;
    }
  }

  Future<void> getStudentCheckedStatus(courseId) async {
    try {
      // Assuming controller.user.value.studentID is available and valid
      CollectionReference studentsRef =
          FirebaseFirestore.instance.collection('Courses').doc(courseId).collection('Students');
      final querySnapshot = await studentsRef.where('StudentID', isEqualTo: controller.user.value.studentID).get();
      if (querySnapshot.docs.isNotEmpty) {
        updateCourseStatus(courseId, 'Checked'); // Ensure this function is async and properly implemented
      }
    } catch (e) {
      print("Error checking student status in course $courseId: $e");
      // Consider handling the error more gracefully, depending on your app's requirements
    }
  }

  void attemptToAccessCourse(String courseId) async {
    Get.close(1);
    bool canAccessWifi = await canAccessCheckWifi(courseId);

    if (canAccessWifi) {
      // อ้างอิงไปยังคอลเลกชัน Students ในคอร์สนั้นๆ
      CollectionReference studentsRef =
          FirebaseFirestore.instance.collection('Courses').doc(courseId).collection('Students');
      final querySnapshot = await studentsRef.where('StudentID', isEqualTo: controller.user.value.studentID).get();
      if (querySnapshot.docs.isEmpty) {
        await studentsRef.add({
          'StudentID': controller.user.value.studentID,
          'StudentName': controller.user.value.fullName,
          'CheckedInAt': Timestamp.fromDate(DateTime.now()),
        });
        MyAppLoader.successSnackBar(title: 'Success', message: 'You have successfully checked attendance in class.!');
        updateCourseStatus(courseId, 'Checked'); // อัปเดตสถานะเป็น 'Checked'
      } else {
        MyAppLoader.warningSnackBar(
            title: 'Already checked', message: "You have already checked attendance in this class.!");
      }
    } else {
      MyAppLoader.errorSnackBar(
          title: 'Access Denied',
          message: "You must be connected to the same WiFi as the instructor to access this course.");
    }
  }

  Future<bool> canAccessCheckWifi(String courseId) async {
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

  Future<void> addCourse(String createdByID, String createdByName) async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Processing...', MyAppImage.loadingAnimation);

      // Check Internet Activity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      final info = NetworkInfo();
      final wifiSSID = await info.getWifiName(); // SSID : MyWifi
      final wifiSubmask = await info.getWifiSubmask(); // Submask : 255.255.255.0

      if (wifiSSID == null || wifiSubmask == null) {
        MyAppLoader.errorSnackBar(
            title: 'Warning', message: "Cannot access WiFi data. Make sure you are connected to WiFi.");
        return;
      }
      if (!courseAddFormKey.currentState!.validate()) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // แปลงค่า duration จาก TextEditingController เป็น int
      final int? durationValue = int.tryParse(duration.text);

      if (durationValue == null) {
        // Handle the case where the duration is not a valid integer
        MyAppLoader.errorSnackBar(title: 'Invalid', message: "Duration must be a Integer number.");
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Generate class code if enabled
      String? classCodeValue = isClassCodeEnabled.value ? classCode.value : null;

      await _db.collection('Courses').add({
        'CourseName': courseName.text.trim(),
        'WifiSSID': wifiSSID,
        'WifiSubmask': wifiSubmask,
        'CreatedAt': Timestamp.now(),
        'CreatedByName': createdByName,
        'CreatedByID': createdByID,
        'ClassCode': classCodeValue,
        'Duration': durationValue,
      });

      fetchCoursesList();
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      Get.close(1);
      MyAppLoader.successSnackBar(title: 'Success', message: 'Successfully added a course!');
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
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

  void toggleClassCodeEnabled(bool isEnabled) {
    isClassCodeEnabled.value = isEnabled;
  }

  void generateClassCode() {
    // This is a simple way to generate a 6-digit code. Adjust as necessary for your needs.
    final rand = Random();
    final code = List.generate(6, (_) => rand.nextInt(10)).join();
    classCode.value = code;
  }
}
