import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/controllers/login/login_controller.dart';
import 'package:workproject/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:workproject/features/authentication/screens/signup/signup.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/validators/validation.dart';

class MyAppLoginForm extends StatelessWidget {
  const MyAppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MyAppSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => MyAppValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MyAppText.email,
                hintText: MyAppText.emailHint,
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields),

            // Password
            Obx(
              () => TextFormField(
                validator: (value) => MyAppValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: MyAppText.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwInputFields / 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(MyAppText.rememberMe),
                  ],
                ),
                // Forgot Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(MyAppText.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // SignIn Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
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
