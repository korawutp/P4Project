import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workproject/screens/1_home/widgets/circle_button.dart';

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
                            ?.copyWith(color: Color(0xFF1A1C20)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Color(0xFFF9813A)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // sliver items 1
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Color(0xFF1A1C20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                        'assets/images/home_images/meow_loading.json',
                        height: 200,
                        width: 200,
                      ),
                      Text(
                        'Add some meow content...',
                        style: TextStyle(
                          color: Color(0xFFFCF1F1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // sliver items 2
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Color(0xFF1A1C20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                          'assets/images/home_images/meow_loading.json',
                          height: 200,
                          width: 200),
                      Text(
                        'Add some meow content...',
                        style: TextStyle(
                          color: Color(0xFFFCF1F1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // sliver items 3
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Color(0xFF1A1C20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                          'assets/images/home_images/meow_loading.json',
                          height: 200,
                          width: 200),
                      Text(
                        'Add some meow content...',
                        style: TextStyle(
                          color: Color(0xFFFCF1F1),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // sliver items 4
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  color: Color(0xFF1A1C20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Lottie.asset(
                          'assets/images/home_images/meow_loading.json',
                          height: 200,
                          width: 200),
                      Text(
                        'Add some meow content...',
                        style: TextStyle(
                          color: Color(0xFFFCF1F1),
                          fontSize: 20,
                        ),
                      ),
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
}
