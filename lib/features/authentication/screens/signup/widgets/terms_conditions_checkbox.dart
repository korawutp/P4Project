import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class MyAppTermsAndConditionCheckbox extends StatelessWidget {
  const MyAppTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 24,
        height: 24,
        child: Checkbox(
          value: true,
          onChanged: (value) {},
        ),
      ),
      const SizedBox(width: MyAppSizes.sm),
      Text.rich(TextSpan(children: [
        TextSpan(
            text: '${MyAppText.iAgreeTo} ',
            style: Theme.of(context).textTheme.bodySmall),
        TextSpan(
            text: '${MyAppText.privacyPolicy}',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: MyAppColors.textPrimary,
                  decoration: TextDecoration.underline,
                  decorationColor: MyAppColors.textPrimary,
                )),
        TextSpan(
            text: ' ${MyAppText.and} ',
            style: Theme.of(context).textTheme.bodySmall),
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
