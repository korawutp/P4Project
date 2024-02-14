import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/data/repository/user/user_repository.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      MyAppFullScreenLoader.openLoadingDialog('We are updating your information...', MyAppImage.loadingAnimation);

      // Check Internet Connecttivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the Firebase Firestore.
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Show Success Message
      MyAppLoader.successSnackBar(title: 'Congratulations', message: 'Your name has been updated');

      // Move to previous screen.
      Get.close(1);
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
  }
}
