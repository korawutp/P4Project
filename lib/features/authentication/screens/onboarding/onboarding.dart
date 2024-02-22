import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:workproject/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:workproject/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:workproject/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:workproject/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: MyAppImage.onBoardingImage1,
                title: MyAppText.onBoardingTitle1,
                subTitle: MyAppText.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: MyAppImage.onBoardingImage2,
                title: MyAppText.onBoardingTitle2,
                subTitle: MyAppText.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: MyAppImage.onBoardingImage3,
                title: MyAppText.onBoardingTitle3,
                subTitle: MyAppText.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation Smooth Page Indicator
          const OnBoardingDotNavigation(),

          // Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
