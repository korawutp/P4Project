import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/widgets/circle_button.dart';
import 'package:workproject/screens/1_home/widgets/silver_item.dart';
import 'package:workproject/utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFCF1F1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFFFD5CD),
            expandedHeight: 100,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Color(0xFFF9813A),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            title: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'H E L L O\nS T U D E N T',
                        style: TextStyle(
                          color: Color(0xFF1A1C20),
                        ),
                      ),
                      CircleButton(
                        icon: Icons.notifications,
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Let's see some interested Meow
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Let's see some interested Meow",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: MyAppColors.black),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: MyAppColors.primary),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // sliver items 1
          SilverItem(),
          SilverItem(),
          SilverItem(),
          SilverItem(),
        ],
      ),
    );
  }
}
