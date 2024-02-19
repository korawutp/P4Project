import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/widgets/home_historybar.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';

class HomeDays extends StatelessWidget {
  const HomeDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Sunday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Sun',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Monday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Mon',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Tuesday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Tue',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Wednesday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Wed',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Thursday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Thu',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Friday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Fri',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),

        // Saturday
        Column(
          children: [
            Historybar(),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Sat',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),
      ],
    );
  }
}
