import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workproject/features/personalization/models/user_model.dart';
import 'package:workproject/utils/exceptions/firebase_exceptions.dart';
import 'package:workproject/utils/exceptions/format_exceptions.dart';
import 'package:workproject/utils/exceptions/platform_exceptions.dart';

/// Repository class for user-related operations.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firebase.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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
}
