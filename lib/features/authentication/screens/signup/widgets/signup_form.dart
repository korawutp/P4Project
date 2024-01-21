import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/controllers/signup/signup_controller.dart';
import 'package:workproject/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/validators/validation.dart';

class MyAppSignUpForm extends StatelessWidget {
  const MyAppSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // Name Fields
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => MyAppValidator.validationEmptyText('First name', value),
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
                  controller: controller.lastName,
                  validator: (value) => MyAppValidator.validationEmptyText('Last name', value),
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
            controller: controller.userName,
            validator: (value) => MyAppValidator.validationEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user_edit),
              labelText: MyAppText.username,
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => MyAppValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: MyAppText.email,
            ),
          ),
          const SizedBox(height: MyAppSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            validator: (value) => MyAppValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.call),
              labelText: MyAppText.phoneNo,
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
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Terms & Conditions Checkbox
          const MyAppTermsAndConditionCheckbox(),
          const SizedBox(height: MyAppSizes.spaceBtwSections),

          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(MyAppText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
