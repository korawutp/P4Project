import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/styles/spacing_styles.dart';
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
      appBar: AppBar(
        title: Text(MyAppText.signupTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: MyAppSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
