import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/features/authentication/controllers/signup/signup_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class MyAppTermsAndConditionCheckbox extends StatelessWidget {
  const MyAppTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(children: [
      SizedBox(
        width: 24,
        height: 24,
        child: Obx(
          () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value, // Checkbox
          ),
        ),
      ),
      const SizedBox(width: MyAppSizes.sm),
      Text.rich(TextSpan(children: [
        TextSpan(text: '${MyAppText.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
        TextSpan(
            text: '${MyAppText.privacyPolicy}',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: MyAppColors.textPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: MyAppColors.textPrimary,
                )),
        TextSpan(text: ' ${MyAppText.and} ', style: Theme.of(context).textTheme.bodySmall),
        TextSpan(
            text: MyAppText.termsOfUse,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: MyAppColors.textPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: MyAppColors.textPrimary,
                )),
      ]))
    ]);
  }
}
