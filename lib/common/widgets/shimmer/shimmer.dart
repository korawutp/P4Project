import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workproject/utils/constants/colors.dart';

class MyAppShimmerEffect extends StatelessWidget {
  const MyAppShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  }) : super(key: key);

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? MyAppColors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
