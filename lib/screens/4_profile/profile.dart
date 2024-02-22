import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/common/widgets/circular_image/circular_image.dart';
import 'package:workproject/common/widgets/shimmer/shimmer.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/features/personalization/screens/view_profile/view_profile.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // It's a good practice to separate your business logic and UI by not initializing controllers directly inside build methods.
    final UserController controller = Get.find<
        UserController>(); // Consider using Get.find instead of Get.put if the controller is initialized elsewhere.

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildProfileHeader(controller),
          _buildSpaceBetweenHeaderAndBody(),
          _buildProfileMenu(),
        ],
      ),
    );
  }

  SliverAppBar _buildProfileHeader(UserController controller) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyAppColors.c1,
      expandedHeight: MyAppHelperFunctions.screenHeight() * 0.3,
      flexibleSpace: FlexibleSpaceBar(
        background: _buildHeaderContent(controller),
      ),
    );
  }

  Container _buildHeaderContent(UserController controller) {
    return Container(
      color: MyAppColors.c3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserProfileImage(controller),
          SizedBox(height: MyAppSizes.sm),
          _buildUserDetails(controller),
        ],
      ),
    );
  }

  Widget _buildUserProfileImage(UserController controller) {
    return Obx(() {
      final String profileImageUrl =
          controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : MyAppImage.profile;
      return MyAppCircularImage(
        image: profileImageUrl,
        width: 100,
        height: 100,
        isNetworkImage: controller.user.value.profilePicture.isNotEmpty,
      );
    });
  }

  Widget _buildUserDetails(UserController controller) {
    return Obx(() {
      if (controller.profileLoading.value) {
        return const MyAppShimmerEffect(width: 100, height: 20);
      } else {
        return Column(
          children: [
            Text(controller.user.value.fullName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: MyAppColors.c1)),
            Text(controller.user.value.studentID, style: TextStyle(fontSize: 14, color: MyAppColors.c1)),
          ],
        );
      }
    });
  }

  SliverToBoxAdapter _buildSpaceBetweenHeaderAndBody() {
    return SliverToBoxAdapter(
      child: SizedBox(height: MyAppHelperFunctions.screenHeight() * 0.03),
    );
  }

  SliverList _buildProfileMenu() {
    return SliverList(
      delegate: SliverChildListDelegate([
        _buildProfileButton('View profile', Iconsax.user, ViewProfileScreen()),
        _buildProfileButton('Settings', Iconsax.setting_2, null), // Replace null with your settings screen widget
        _buildProfileButton('Logout', Iconsax.logout, null), // Add your logout logic here
      ]),
    );
  }

  Widget _buildProfileButton(String title, IconData icon, Widget? destination) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (destination != null) {
          Get.to(() => destination);
        } else {
          // Handle null destination (e.g., Logout)
          if (title == 'Logout') {
            Get.find<UserController>().logoutAccount();
          }
        }
      },
    );
  }
}
