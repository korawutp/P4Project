import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/widgets/login_signup/form_divider.dart';
import 'package:workproject/common/widgets/login_signup/social_buttons.dart';
import 'package:workproject/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(MyAppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  MyAppText.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: MyAppSizes.spaceBtwSections),

                // Form
                const MyAppSignUpForm(),
                const SizedBox(height: MyAppSizes.spaceBtwSections),

                // Divider
                MyAppFormDivider(
                    dividerText: MyAppText.orSignUpWith.capitalize!),
                const SizedBox(height: MyAppSizes.spaceBtwSections),

                // Social Buttons
                const MyAppSocialButtons(),
              ],
            )),
      ),
    );
  }
}
