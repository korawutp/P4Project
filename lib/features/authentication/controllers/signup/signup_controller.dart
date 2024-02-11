import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/data/repository/authentication/authentication_repository.dart';
import 'package:workproject/data/repository/user/user_repository.dart';
import 'package:workproject/features/authentication/screens/signup/verify_email.dart';
import 'package:workproject/features/personalization/models/user_model.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  // final userName = TextEditingController(); // Controller for username input
  final studentID = TextEditingController(); // Controller for last name input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber = TextEditingController(); // Controller for phone number input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('We are processing your information...', MyAppImage.loadingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        MyAppLoader.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        // Remove Loader
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final UserCredential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: UserCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        // userName: userName.text.trim(),
        studentID: studentID.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show Success Message
      MyAppLoader.successSnackBar(
          title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      // Move to Verify Email.com Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
  }
}
