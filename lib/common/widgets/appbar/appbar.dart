import 'package:flutter/material.dart';
import 'package:workproject/screens/1_home/widgets/circle_button.dart';
import 'package:workproject/utils/constants/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.darkMode,
  });

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: darkMode ? MyAppColors.tertiary : MyAppColors.secondary,
      expandedHeight: 100,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: MyAppColors.primary,
        ),
      ),
      title: Column(
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
    );
  }
}
