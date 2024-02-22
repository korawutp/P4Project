import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';

class HomeMoods extends StatelessWidget {
  const HomeMoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyAppColors.c4,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(6),
              child: Center(
                child: Icon(Icons.sentiment_very_dissatisfied),
              ),
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Awful',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyAppColors.c4,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(6),
              child: Center(
                child: Icon(Icons.sentiment_dissatisfied),
              ),
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Bad',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyAppColors.c4,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(6),
              child: Center(
                child: Icon(Icons.sentiment_neutral),
              ),
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'So-so',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyAppColors.c4,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(6),
              child: Center(
                child: Icon(Icons.sentiment_satisfied),
              ),
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Good',
              style: TextStyle(
                color: MyAppColors.c2,
              ),
            )
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyAppColors.c4,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(6),
              child: Center(
                child: Icon(Icons.sentiment_very_satisfied),
              ),
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
            Text(
              'Happy!',
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
