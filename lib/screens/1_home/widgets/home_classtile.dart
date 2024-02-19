import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/theme/custom_themes/text_theme.dart';

class HomeClasstile extends StatelessWidget {
  final icon;
  final String className;
  final String classNumber;
  final color;

  const HomeClasstile({
    Key? key,
    required this.icon,
    required this.className,
    required this.classNumber,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyAppColors.c1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      color: color,
                      child: Icon(icon, color: MyAppColors.c1)),
                ),
                const SizedBox(
                  width: MyAppSizes.iconXs,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(classNumber,
                        style: MyAppTextTheme.lightTextTheme.titleLarge
                            ?.copyWith(color: MyAppColors.c5)),
                    // subtitle
                    Text(
                      className,
                      style: MyAppTextTheme.lightTextTheme.bodySmall
                          ?.copyWith(color: MyAppColors.c2),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.more_horiz),
          ],
        ),
      ),
    );
  }
}
