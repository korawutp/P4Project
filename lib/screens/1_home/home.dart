import 'package:flutter/material.dart';
import 'package:workproject/common/styles/spacing_styles.dart';
import 'package:workproject/common/widgets/shimmer/shimmer.dart';
import 'package:workproject/screens/1_home/widgets/home_classtile.dart';
import 'package:workproject/screens/1_home/widgets/home_moods.dart';
import 'package:workproject/screens/1_home/widgets/home_searchbar.dart';
import 'package:get/get.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/theme/custom_themes/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      backgroundColor: MyAppColors.c1,
      body: Column(
        children: [
          const SizedBox(
            height: MyAppSizes.spaceBtwSections,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MyAppSizes.defaultSpace),
            child: Column(
              children: [
                //* Hi Row
                _buildGreetingRow(controller),

                const SizedBox(
                  height: MyAppSizes.defaultSpace,
                ),

                //* search bar
                HomeSearchBar(),

                const SizedBox(
                  height: MyAppSizes.defaultSpace,
                ),

                //* mini history page
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(MyAppText.howWasYourClass,
                        style: MyAppTextTheme.lightTextTheme.headlineSmall),
                  ],
                ),

                const SizedBox(
                  height: MyAppSizes.sm,
                ),

                //* check ur mood
                HomeMoods(),

                const SizedBox(
                  height: MyAppSizes.defaultSpace,
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
              child: Container(
                padding: MyAppSpacingStyle.paddingWithAppBarHeight,
                color: MyAppColors.c3,
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyAppText.enrolledClass,
                              style: MyAppTextTheme.lightTextTheme.headlineSmall
                                  ?.copyWith(color: MyAppColors.c1)),
                        ],
                      ),
                      const SizedBox(
                        height: MyAppSizes.defaultSpace,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            HomeClasstile(
                              icon: Icons.class_,
                              classNumber: '305491',
                              className: 'Computer Engineering...',
                              color: Colors.orange,
                            ),
                            HomeClasstile(
                              icon: Icons.class_,
                              classNumber: '305492',
                              className: 'Computer Engineering...',
                              color: Colors.blue,
                            ),
                            HomeClasstile(
                              icon: Icons.class_,
                              classNumber: '000000',
                              className: 'Classname',
                              color: Colors.green,
                            ),
                            HomeClasstile(
                              icon: Icons.class_,
                              classNumber: '111111',
                              className: 'Classname',
                              color: Colors.pink,
                            ),
                            HomeClasstile(
                              icon: Icons.class_,
                              classNumber: '222222',
                              className: 'Classname',
                              color: Colors.purple,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //* Hi Row แสดงชื่อ
  Row _buildGreetingRow(UserController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () {
            if (controller.profileLoading.value) {
              return const MyAppShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                'Hello ${controller.user.value.firstName}!',
                style: MyAppTextTheme.lightTextTheme.headlineMedium,
              );
            }
          },
        ),
      ],
    );
  }
}
