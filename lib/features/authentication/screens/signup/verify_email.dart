import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/widgets/success_screen/success_screen.dart';
import 'package:workproject/features/authentication/screens/login/login.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // To not show back button
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
          // Padding to Give Default Equally Space on all Side in all screen
          child: Padding(
        padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
        child: Column(children: [
          // Image
          Image(
            image: const AssetImage(MyAppImage.verificationImage1),
            width: MyAppHelperFunctions.screenWidth() * 0.6,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Title & Subtitle
          Text(
            MyAppText.verifyEmail,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          Text(
            'support@example.com',
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          Text(
            MyAppText.verifyEmailSubTitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => SuccessScreen(
                    image: MyAppImage.staticSuccessImage,
                    title: MyAppText.yourAccountCreatedTitle,
                    subTitle: MyAppText.yourAccountCreatedSubTitle,
                    onPressed: () => Get.to(() => const LoginScreen()),
                  )),
              child: const Text(MyAppText.textContinue),
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text(MyAppText.resendEmail),
            ),
          ),
        ]),
      )),
    );
  }
}
