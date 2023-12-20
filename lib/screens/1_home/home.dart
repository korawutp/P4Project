import 'package:flutter/material.dart';
import 'package:workproject/common/widgets/appbar/appbar.dart';
import 'package:workproject/screens/1_home/widgets/silver_item.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = MyAppHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? MyAppColors.dark : MyAppColors.light,
      body: CustomScrollView(
        slivers: [
          // Appbar
          MyAppBar(darkMode: darkMode),

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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: darkMode
                                ? MyAppColors.light
                                : MyAppColors.dark),
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

          // sliver items
          SilverItem(),
          SilverItem(),
          SilverItem(),
          SilverItem(),
          SilverItem(),
          SilverItem(),
        ],
      ),
    );
  }
}
