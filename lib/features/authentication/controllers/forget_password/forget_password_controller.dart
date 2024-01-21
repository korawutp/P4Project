import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/data/repository/authentication/authentication_repository.dart';
import 'package:workproject/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Processing your request...', MyAppImage.loadingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show Success Screen
      MyAppLoader.successSnackBar(title: 'Email Sent', message: 'Email link sent to reset your password'.tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Processing your request...', MyAppImage.loadingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show Success Screen
      MyAppLoader.successSnackBar(title: 'Email Sent', message: 'Email link sent to reset your password'.tr);

    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning', message: e.toString());
    }
  }
}
