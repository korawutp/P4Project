import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workproject/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/device/device_utility.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = MyAppHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: MyAppDeviceUtility.getBottomNavigationBarHeight() + 25,
      left: MyAppSizes.defaultSpace,
      child: SmoothPageIndicator(
        count: 3,
        controller: controller.pageController,
        // onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? MyAppColors.light : MyAppColors.dark,
            dotHeight: 6),
      ),
    );
  }
}
