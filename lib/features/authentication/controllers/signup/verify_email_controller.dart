import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:workproject/common/widgets/success_screen/success_screen.dart';
import 'package:workproject/data/repository/authentication/authentication_repository.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send e-mail whenever verify screen appears & set timer for auto redirect.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MyAppLoader.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
    } catch (e) {
      MyAppLoader.errorSnackBar(title: 'Warning!', message: e.toString());
    }
  }

  /// Timer to automatically redirect on e-mail verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: MyAppImage.staticSuccessImage,
            title: MyAppText.yourAccountCreatedTitle,
            subTitle: MyAppText.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  /// Manually check if e-mail verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: MyAppImage.staticSuccessImage,
          title: MyAppText.yourAccountCreatedTitle,
          subTitle: MyAppText.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
