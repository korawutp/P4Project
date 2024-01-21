import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/styles/spacing_styles.dart';
import 'package:workproject/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:workproject/features/authentication/screens/login/login.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: MyAppSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(children: [
          // Image
          Image(
            image: AssetImage(MyAppImage.resetPasswordImage),
            width: MyAppHelperFunctions.screenWidth() * 0.6,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Email, Title & Subtitle
          Text(
            email,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          Text(
            MyAppText.resetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          Text(
            MyAppText.resetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              child: const Text(MyAppText.done),
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => controller.resendPasswordResetEmail(email),
              child: const Text(MyAppText.resendEmail),
            ),
          ),
        ]),
      )),
    );
  }
}
