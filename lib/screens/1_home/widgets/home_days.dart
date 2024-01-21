import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/widgets/home_historybar.dart';

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
            SizedBox(
              height: 8,
            ),
            Text(
              'Sun',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Monday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Mon',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Tuesday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Tue',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Wednesday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Wed',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Thursday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Thu',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Friday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Fri',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),

        // Saturday
        Column(
          children: [
            Historybar(),
            SizedBox(
              height: 8,
            ),
            Text(
              'Sat',
              style: TextStyle(
                color: Color(0xFFFCF1F1),
              ),
            )
          ],
        ),
      ],
    );
  }
}
