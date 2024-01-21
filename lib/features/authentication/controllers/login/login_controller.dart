import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workproject/data/repository/authentication/authentication_repository.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class LoginController extends GetxController {
  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  @override
  void onInit() {
    if (localStorage.read('REMEMBER_ME_EMAIL') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    }
    super.onInit();
  }

  /// -- Email & Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Logging you in...', MyAppImage.loadingAnimation);

      // Check Internet Activity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using email & password authentication
      final userCredentials =
          await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save User Record
      await userController.saveUserRecord(userCredentials);
      
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
  }

  /// -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('Logging you in...', MyAppImage.loadingAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
  }
}
