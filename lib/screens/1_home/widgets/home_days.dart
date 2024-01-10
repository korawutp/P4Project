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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
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
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
