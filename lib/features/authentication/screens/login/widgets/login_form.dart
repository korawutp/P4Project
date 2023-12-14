import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:workproject/features/authentication/screens/signup/signup.dart';
import 'package:workproject/navigation_menu.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class MyAppLoginForm extends StatelessWidget {
  const MyAppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: MyAppSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MyAppText.email,
                hintText: MyAppText.emailHint,
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: MyAppText.password,
                hintText: MyAppText.passwordHint,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields / 2),

            // Remember Me and Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(MyAppText.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(MyAppText.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const NavigationMenu()),
                child: const Text(MyAppText.signIn),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwItems),
            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(MyAppText.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
