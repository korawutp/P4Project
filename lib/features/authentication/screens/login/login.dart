import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:workproject/common/styles/spacing_styles.dart';
// import 'package:workproject/common/widgets/login_signup/form_divider.dart';
// import 'package:workproject/common/widgets/login_signup/social_buttons.dart';
import 'package:workproject/features/authentication/screens/login/widgets/login_form.dart';
import 'package:workproject/features/authentication/screens/login/widgets/login_header.dart';
// import 'package:workproject/utils/constants/sizes.dart';
// import 'package:workproject/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MyAppSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Header
              const MyAppLoginHeader(),

              // Form
              const MyAppLoginForm(),

              // // Divider
              // MyAppFormDivider(dividerText: MyAppText.orSignInWith.capitalize!),
              // const SizedBox(height: MyAppSizes.spaceBtwSections),

              // // Footer
              // const MyAppSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
