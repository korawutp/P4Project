import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';

/// -- Light & Dark Outlined Button Theme --
class MyAppOutlinedButtonTheme {
  MyAppOutlinedButtonTheme._();

  /// -- Light Outlined Button Theme --
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: MyAppColors.c2,
      side: const BorderSide(color: MyAppColors.c2),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        color: MyAppColors.c2,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );

  /// -- Dark Outlined Button Theme --
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(color: MyAppColors.c1),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}
