import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workproject/data/repository/authentication/authentication_repository.dart';
import 'package:workproject/data/repository/user/user_repository.dart';
import 'package:workproject/features/authentication/screens/login/login.dart';
import 'package:workproject/features/personalization/models/user_model.dart';
import 'package:workproject/features/personalization/screens/edit_profile/widgets/re_authenticate_user_login_form.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/helpers/network_manager.dart';
import 'package:workproject/utils/popups/full_screen_loader.dart';
import 'package:workproject/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First update Rx user and then check if user data is already stored. If not store new data.
      await fetchUserRecord();

      // If no record already Stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          // final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            // userName: username,
            studentID: '',
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      MyAppLoader.warningSnackBar(
          title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile.');
    }
  }

  /// Logout account
  Future<void> logoutAccount() async {
    try {
      MyAppFullScreenLoader.openLoadingDialog('Processing...', MyAppImage.loadingAnimation);
      final auth = AuthenticationRepository.instance;
      await auth.logout();
      MyAppFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.warningSnackBar(title: 'Warning!', message: e.toString());
    }
  }

  /// Delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MyAppSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be remove permanently.',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
        ));
  }

  /// Delete User Account
  Future<void> deleteUserAccount() async {
    try {
      MyAppFullScreenLoader.openLoadingDialog('Processing...', MyAppImage.loadingAnimation);

      /// First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          MyAppFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          MyAppFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.warningSnackBar(title: 'Warning!', message: e.toString());
    }
  }

  /// -- Re-Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      MyAppFullScreenLoader.openLoadingDialog('Processing...', MyAppImage.loadingAnimation);

      // Check Internet Connecttivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        MyAppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      // Remove Loader
      MyAppFullScreenLoader.stopLoading();

      // Move to previous screen.
      Get.off(() => const LoginScreen());
    } catch (e) {
      MyAppFullScreenLoader.stopLoading();
      MyAppLoader.warningSnackBar(title: 'Warning!', message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image =
          await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Upload image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        MyAppLoader.successSnackBar(title: 'Congratulations', message: 'Your profile image has been updated!');
      }
    } catch (e) {
      MyAppLoader.errorSnackBar(title: 'Warning', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
