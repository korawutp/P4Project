import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';

class MyAppSocialButtons extends StatelessWidget {
  const MyAppSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyAppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: MyAppSizes.iconMd,
              height: MyAppSizes.iconMd,
              image: AssetImage(MyAppImage.google),
            ),
          ),
        ),
        const SizedBox(width: MyAppSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MyAppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: MyAppSizes.iconMd,
              height: MyAppSizes.iconMd,
              image: AssetImage(MyAppImage.facebook),
            ),
          ),
        )
      ],
    );
  }
}
