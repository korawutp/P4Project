//! popupnotification
//! touchable mini_history

import 'package:flutter/material.dart';
import 'package:workproject/common/widgets/shimmer/shimmer.dart';
import 'package:workproject/screens/1_home/widgets/home_classtile.dart';
import 'package:workproject/screens/1_home/widgets/home_days.dart';
import 'package:workproject/screens/1_home/widgets/home_searchbar.dart';
import 'package:workproject/screens/3_history/history.dart';
import 'package:get/get.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/colors.dart';

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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //* Hi Row
                _buildGreetingRow(controller),

                SizedBox(
                  height: 20,
                ),

                //* search bar
                HomeSearchBar(),

                SizedBox(
                  height: 20,
                ),

                //* mini history page
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How was your class today?',
                      style: TextStyle(
                        color: MyAppColors.c2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen()));
                      },
                      child: Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: MyAppColors.c2,
                              fontSize: 12,
                            ),
                      ),
                    )
                  ],
                ),

                //* mini history
                HomeDays(),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                color: MyAppColors.c3,
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's see your enrolled class",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: MyAppColors.c1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
                'Hello ${controller.user.value.firstName} !',
                style: const TextStyle(
                  color: MyAppColors.c2,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
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
}
