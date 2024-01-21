import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Historybar extends StatelessWidget {
  const Historybar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFD5CD),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(6),
      child: Center(
        child: Lottie.asset(
          'assets/images/home_images/meow_loading.json',
          width: 25,
          height: 25,
        ),
      ),
    );
  }
}
