import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/features/course/models/course_model.dart';
import 'package:workproject/utils/exceptions/firebase_exceptions.dart';
import 'package:workproject/utils/exceptions/format_exceptions.dart';
import 'package:workproject/utils/exceptions/platform_exceptions.dart';

/// Repository class for user-related operations.
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

  /// Function to fetch course details based on user ID.
  Future<CourseModel> fetchCourseDetails() async {
    try {
      final documentSnapshot = await _db.collection("Courses").doc().get();
      if (documentSnapshot.exists) {
        return CourseModel.fromSnapshot(documentSnapshot);
      } else {
        return CourseModel.empty();
      }
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
}
