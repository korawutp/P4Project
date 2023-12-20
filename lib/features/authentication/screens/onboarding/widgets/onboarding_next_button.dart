import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/device/device_utility.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Positioned(
      right: MyAppSizes.defaultSpace,
      bottom: MyAppDeviceUtility.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide.none, // Removes border
            shape: const CircleBorder(),
            backgroundColor: dark ? MyAppColors.primary : MyAppColors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
