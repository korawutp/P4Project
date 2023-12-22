import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workproject/utils/constants/colors.dart';

class SilverItem extends StatelessWidget {
  const SilverItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 300,
            color: MyAppColors.tertiary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.network(
                    'https://lottie.host/01438a16-4ea9-4c98-be25-361e563b7478/gyor0EiwNn.json',
                    height: 200,
                    width: 200),
                Text(
                  'Add some meow content...',
                  style: TextStyle(
                    color: MyAppColors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
