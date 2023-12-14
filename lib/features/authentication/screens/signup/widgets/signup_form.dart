import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/screens/signup/verify_email.dart';
import 'package:workproject/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class MyAppSignUpForm extends StatelessWidget {
  const MyAppSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Name Fields
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: MyAppText.firstName,
                  ),
                ),
              ),
              const SizedBox(width: MyAppSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: MyAppText.lastName,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user_edit),
              labelText: MyAppText.username,
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: MyAppText.email,
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.call),
              labelText: MyAppText.phoneNo,
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: MyAppText.password,
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Terms & Conditions Checkbox
          const MyAppTermsAndConditionCheckbox(),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(MyAppText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
