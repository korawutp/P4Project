import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class MyAppLoginHeader extends StatelessWidget {
  const MyAppLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 100,
          image: AssetImage(MyAppImage.appLogo),
        ),
        Text(
          MyAppText.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MyAppSizes.sm),
        Text(
          MyAppText.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
