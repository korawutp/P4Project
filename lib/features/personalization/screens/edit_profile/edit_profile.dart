import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/common/widgets/circular_image/circular_image.dart';
import 'package:workproject/common/widgets/shimmer/shimmer.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/features/personalization/screens/edit_profile/widgets/change_name.dart';
import 'package:workproject/features/personalization/screens/edit_profile/widgets/profile_menu.dart';
import 'package:workproject/features/personalization/screens/edit_profile/widgets/section_heading.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/formatters/formatter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
          child: Column(children: [
            /// Profile Picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image = networkImage.isNotEmpty ? networkImage : MyAppImage.profile;
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        controller.imageUploading.value
                            ? const MyAppShimmerEffect(
                                width: 120,
                                height: 120,
                                radius: 80,
                              )
                            : MyAppCircularImage(
                                image: image,
                                width: 120,
                                height: 120,
                                isNetworkImage: networkImage.isNotEmpty,
                              ),
                        Positioned(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100), color: MyAppColors.white.withOpacity(0.4)),
                            child: IconButton(
                              icon: Icon(Iconsax.edit),
                              onPressed: () => controller.uploadUserProfilePicture(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: MyAppSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            /// Heading Profile Info
            const MyAppSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            MyAppProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName())),
            // MyAppProfileMenu(title: 'Username', value: controller.user.value.userName, onPressed: () {}),
            MyAppProfileMenu(title: 'Student ID', value: controller.user.value.studentID, onPressed: () {}),

            const SizedBox(height: MyAppSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            /// Heading Profile Info
            const MyAppSectionHeading(
              title: 'Personal Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            // MyAppProfileMenu(title: 'User ID', value: controller.user.value.id, icon: Iconsax.copy, onPressed: () {}),
            MyAppProfileMenu(title: 'E-mail', value: controller.user.value.email, onPressed: () {}),
            MyAppProfileMenu(
                title: 'Phone No.',
                value: MyAppFormatter.formatPhoneNumber(controller.user.value.phoneNumber),
                onPressed: () {}),
            MyAppProfileMenu(title: 'Date of Birth', value: '12 May, 199x', onPressed: () {}),
            const Divider(),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            Center(
              child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
