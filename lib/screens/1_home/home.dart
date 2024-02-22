import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/styles/spacing_styles.dart';
import 'package:workproject/common/widgets/shimmer/shimmer.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/screens/1_home/widgets/home_classtile.dart';
import 'package:workproject/screens/1_home/widgets/home_days.dart';
import 'package:workproject/screens/1_home/widgets/home_searchbar.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/theme/custom_themes/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.c1,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopSection(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyAppSizes.defaultSpace),
      child: Column(
        children: [
          _buildGreetingRow(),
          const SizedBox(height: MyAppSizes.defaultSpace),
          const HomeSearchBar(),
          const SizedBox(height: MyAppSizes.defaultSpace),
          _buildMiniHistoryTitle(),
          const SizedBox(height: MyAppSizes.sm),
          const HomeDays(),
          const SizedBox(height: MyAppSizes.defaultSpace),
        ],
      ),
    );
  }

  Widget _buildGreetingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          if (controller.profileLoading.value) {
            return const MyAppShimmerEffect(width: 80, height: 15);
          } else {
            return Text(
              'Hello ${controller.user.value.firstName}!',
              style: MyAppTextTheme.lightTextTheme.headlineMedium,
            );
          }
        }),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: MyAppColors.c2,
            fixedSize: const Size(50, 50),
          ),
          icon: const Icon(Icons.notifications, color: MyAppColors.c1),
        ),
      ],
    );
  }

  Widget _buildMiniHistoryTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(MyAppText.howWasYourClass, style: MyAppTextTheme.lightTextTheme.headlineSmall),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        child: Container(
          padding: MyAppSpacingStyle.paddingWithAppBarHeight,
          color: MyAppColors.c3,
          child: _buildEnrolledClassesList(),
        ),
      ),
    );
  }

  Widget _buildEnrolledClassesList() {
    return Column(
      children: [
        const SizedBox(height: MyAppSizes.defaultSpace),
        Text(MyAppText.enrolledClass,
            style: MyAppTextTheme.lightTextTheme.headlineSmall?.copyWith(color: MyAppColors.c1)),
        const SizedBox(height: MyAppSizes.defaultSpace),
        Expanded(
          child: ListView(
            children: const [
              HomeClasstile(
                  icon: Icons.class_,
                  classNumber: '305491',
                  className: 'Computer Engineering...',
                  color: Colors.orange),
              HomeClasstile(
                  icon: Icons.class_, classNumber: '305492', className: 'Computer Engineering...', color: Colors.blue),
              HomeClasstile(icon: Icons.class_, classNumber: '000000', className: 'Classname', color: Colors.green),
              HomeClasstile(icon: Icons.class_, classNumber: '111111', className: 'Classname', color: Colors.pink),
              HomeClasstile(icon: Icons.class_, classNumber: '222222', className: 'Classname', color: Colors.purple),
            ],
          ),
        )
      ],
    );
  }
}
