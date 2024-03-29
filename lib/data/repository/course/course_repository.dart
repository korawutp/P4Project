import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
import 'package:workproject/screens/2_classcheck/course/models/student_model.dart';
import 'package:workproject/utils/exceptions/firebase_exceptions.dart';
import 'package:workproject/utils/exceptions/format_exceptions.dart';
import 'package:workproject/utils/exceptions/platform_exceptions.dart';

class CourseRepository extends GetxController {
  static CourseRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save course data to Firestore.
  Future<void> saveCourseRecord(CourseModel course) async {
    try {
      await _db.collection("Courses").doc(course.id).set(course.toJson());
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch a list of course details.
  Future<List<CourseModel>> fetchCourseList() async {
    try {
      final querySnapshot = await _db.collection("Courses").get();
      final courses = querySnapshot.docs.map((doc) => CourseModel.fromSnapshot(doc)).toList();
      return courses;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException {
      throw MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<List<CourseModel>> fetchCoursesByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    try {
      final querySnapshot = await _db
          .collection("Courses")
          .where("CreatedAt", isGreaterThanOrEqualTo: startOfDay)
          .where("CreatedAt", isLessThanOrEqualTo: endOfDay)
          .get();

      final courses = querySnapshot.docs.map((doc) => CourseModel.fromSnapshot(doc)).toList();

      return courses;
    } on FirebaseException catch (e) {
      throw MyAppFirebaseException(e.code).message;
    } on FormatException {
      throw MyAppFormatException();
    } on PlatformException catch (e) {
      throw MyAppPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Something went wrong. Please try again');
    }
  }

  Future<List<StudentModel>> fetchStudentsByCourseId(String courseId) async {
    final querySnapshot = await _db.collection("Courses").doc(courseId).collection("Students").get();

    final students = querySnapshot.docs.map((doc) => StudentModel.fromSnapshot(doc)).toList();

    return students;
  }
}
