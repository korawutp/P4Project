import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/screens/4_profile/widgets/profile_menu.dart';
import 'package:workproject/screens/4_profile/widgets/section_heading.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      MyAppImage.profile,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Change Profile Picture')),
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

            MyAppProfileMenu(title: 'Name', value: 'John Doe', onPressed: () {}),
            MyAppProfileMenu(title: 'Student ID', value: '6336xxxx', onPressed: () {}),

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

            MyAppProfileMenu(title: 'User ID', value: '012xx', icon: Iconsax.copy, onPressed: () {}),
            MyAppProfileMenu(title: 'E-mail', value: 'john.doe@example.com', onPressed: () {}),
            MyAppProfileMenu(title: 'Phone Number', value: '012-345-6789', onPressed: () {}),
            MyAppProfileMenu(title: 'Date of Birth', value: '13 Oct, 199x', onPressed: () {}),
            const Divider(),
            const SizedBox(
              height: MyAppSizes.spaceBtwItems,
            ),

            Center(
              child: TextButton(
                  onPressed: () {},
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
