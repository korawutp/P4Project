import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';

/// -- Custom Themes --
import 'package:workproject/utils/theme/custom_themes/text_theme.dart';
import 'package:workproject/utils/theme/custom_themes/chip_theme.dart';
import 'package:workproject/utils/theme/custom_themes/appbar_theme.dart';
import 'package:workproject/utils/theme/custom_themes/buttom_sheet_theme.dart';
import 'package:workproject/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:workproject/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:workproject/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:workproject/utils/theme/custom_themes/text_field_theme.dart';

class AppTheme {
  AppTheme._();

  /// -- Light Theme --
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    brightness: Brightness.light,
    primaryColor: MyAppColors.c1,
    textTheme: MyAppTextTheme.lightTextTheme,
    chipTheme: MyAppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: MyAppColors.c1,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyAppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyAppButtomSheetTheme.lightButtomSheetTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.lightInputDecorationTheme,
  );

  /// -- Dark Theme --
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    brightness: Brightness.light,
    primaryColor: MyAppColors.c1,
    textTheme: MyAppTextTheme.lightTextTheme,
    chipTheme: MyAppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: MyAppColors.c1,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyAppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyAppButtomSheetTheme.lightButtomSheetTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.lightInputDecorationTheme,
  );
}
