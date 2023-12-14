import 'package:flutter/material.dart';
import 'package:workproject/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MyAppDeviceUtility.getAppBarHeight(),
        right: MyAppSizes.defaultSpace,
        child: TextButton(
            onPressed: () => OnBoardingController.instance.skipPage(),
            child: const Text('Skip')));
  }
}
