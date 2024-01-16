import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/authentication/screens/login/login.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

import 'screens/edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyAppColors.tertiary,
            expandedHeight: MyAppHelperFunctions.screenHeight() * 0.3,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: MyAppColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        MyAppImage.profile,
                      ),
                    ),
                    SizedBox(height: 10), // Add some space between the avatar and text
                    Text(
                      'John Doe', // Replace with the actual name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'john.doe@example.com', // Replace with the actual email
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // make some space between the header and body
          SliverToBoxAdapter(
            child: SizedBox(
              height: MyAppHelperFunctions.screenHeight() * 0.03,
            ),
          ),

          // Body
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Profile Button
                ListTile(
                    leading: Icon(Iconsax.user_edit),
                    title: Text('Edit Profile'),
                    onTap: () => Get.to(() => const EditProfileScreen())),

                // Settings Button
                ListTile(
                  leading: Icon(Iconsax.setting_2),
                  title: Text('Settings'),
                  onTap: () {
                    // Handle settings button tap
                    // Navigate to settings screen or perform other actions
                  },
                ),

                // Logout Button
                ListTile(
                  leading: Icon(Iconsax.logout),
                  title: Text('Logout'),
                  onTap: () => Get.offAll(() => const LoginScreen()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildProfileButton(String title, IconData icon) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: InkWell(
      onTap: () {
        // Handle button tap
        if (title == 'Edit Profile') {
          // Handle Edit Profile button tap
        } else if (title == 'Settings') {
          // Handle Settings button tap
        } else if (title == 'Logout') {
          // Handle Logout button tap
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
