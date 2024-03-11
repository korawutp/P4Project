import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';

class HomeClasstile extends StatelessWidget {
  final icon;

  final color;

  const HomeClasstile({
    Key? key,
    required this.icon,
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
        child: Lottie.asset(MyAppImage.meowLoading, height: 50, width: 50),
      ),
    );
  }
}
