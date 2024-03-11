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
  RxBool hasNewCourse = false.obs;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
    fetchCoursesList();
  }

  void listenToNewCourses() {
    FirebaseFirestore.instance.collection('Courses').snapshots().listen((snapshot) {
      // Assuming 'hasNewCourse' is a RxBool in your controller
      // This is a simple example; you might want to refine the logic
      // to only trigger for new additions.
      hasNewCourse.value = true;
    });
  }

  /// Fetch course record
  Future<void> fetchCoursesList() async {
    courseLoading.value = true;
    try {
      final courses = await courseRepository.fetchCourseList();

      courseList.value = courses;
    } catch (e) {
      MyAppLoader.errorSnackBar(title: 'Error', message: "Cannot fetch courses: $e");
    } finally {
      courseLoading.value = false;
    }
  }

  // Function to filter active courses
  List<CourseModel> getActiveCourses() {
    final DateTime thirtyMinutesAgo = DateTime.now().subtract(Duration(minutes: 60));
    var activeCourses = courseList.value.where((course) {
      DateTime expireTime = course.createdAt.add(Duration(minutes: course.durationMinutes));
      return expireTime.isAfter(thirtyMinutesAgo);
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return activeCourses;
  }

  Future<void> getStudentCheckedStatus(courseId) async {
    try {
      CollectionReference studentsRef =
          FirebaseFirestore.instance.collection('Courses').doc(courseId).collection('Students');
      final querySnapshot = await studentsRef.where('StudentID', isEqualTo: controller.user.value.studentID).get();
      if (querySnapshot.docs.isNotEmpty) {
        updateCourseStatus(courseId, 'Checked');
      }
    } catch (e) {
      // MyAppLoader.errorSnackBar(title: 'Error', message: "Error checking student status for course${courseId}: $e");
      throw Exception("Error checking student status for class $courseId: $e");
    }
  }

  void updateCourseStatus(String id, String newStatus) {
    if (courseStatuses.containsKey(id)) {
      courseStatuses[id]!.value = newStatus;
    } else {
      courseStatuses[id] = RxString(newStatus);
    }
  }

  void attemptToAccessCourse(String courseId) async {
    // Fetch course status (assuming you have a method to do this)
    String courseStatus = getCourseStatus(courseId);

    // Check if the course status is "expired"
    if (courseStatus == 'Expired') {
      MyAppLoader.errorSnackBar(
        title: 'Check-in Failed',
        message: "This class is expired and no longer accepts check-ins.",
      );
      return; // Exit the method to prevent further execution.
    }
    final doc = await FirebaseFirestore.instance.collection('Courses').doc(courseId).get();
    if (!doc.exists) {
      MyAppLoader.errorSnackBar(title: 'Error', message: "Class not found.");
      return;
    }

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
          message: "You must be connected to the same WiFi as the instructor to access this class.");
    }
  }

  void attemptToAccessCourseWithCode(String courseId, String enteredClassCode) async {
    // Fetch course status (assuming you have a method to do this)
    String courseStatus = getCourseStatus(courseId);

    // Check if the course status is "expired"
    if (courseStatus == 'Expired') {
      MyAppLoader.errorSnackBar(
        title: 'Check-in Failed',
        message: "This class is expired and no longer accepts check-ins.",
      );
      return; // Exit the method to prevent further execution.
    }

    final doc = await FirebaseFirestore.instance.collection('Courses').doc(courseId).get();
    if (!doc.exists) {
      MyAppLoader.errorSnackBar(title: 'Error', message: "Class not found.");
      return;
    }

    final String? classCode = doc.data()?['ClassCode'];
    // Check if a class code is required and if the entered code matches
    if (classCode != null && classCode.isNotEmpty) {
      if (enteredClassCode != classCode) {
        MyAppLoader.errorSnackBar(
          title: 'Access Denied',
          message: "Incorrect class code. Please try again.",
        );
        return;
      }
    }

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
          message: "You must be connected to the same WiFi as the instructor to access this class.");
    }
  }

  Future<bool> canAccessCheckWifi(String courseId) async {
    final info = NetworkInfo();
    final wifiSSID = await info.getWifiName();
    final wifiSubmask = await info.getWifiSubmask();

    if (wifiSSID == null || wifiSubmask == null) {
      MyAppLoader.errorSnackBar(title: 'Warning', message: "You are not connected to WiFi.");
      return false;
    }

    final doc = await _db.collection('Courses').doc(courseId).get();

    if (!doc.exists) {
      MyAppLoader.errorSnackBar(title: 'Error', message: "Class not found.");
      return false;
    }

    final courseWifiSSID = doc.data()?['WifiSSID'];
    final courseWifiSubmask = doc.data()?['WifiSubmask'];
    if (courseWifiSSID != wifiSSID || courseWifiSubmask != wifiSubmask) {
      MyAppLoader.errorSnackBar(
          title: 'Access Denied', message: "Your WiFi connection does not match the class requirements.");
      return false;
    }

    return true;
  }

  Future<void> addCourse(String createdByID, String createdByName) async {
    if (!courseAddFormKey.currentState!.validate()) {
      MyAppLoader.errorSnackBar(title: 'Invalid Form', message: "Please fill all required fields correctly.");
      return;
    }
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
      MyAppLoader.successSnackBar(title: 'Success', message: 'Successfully added a class!');
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
