import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/bindings/general_bindings.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/theme/theme.dart';

/// -- Use this Class to set the themes, initial Binding, etc --
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      initialBinding: GeneralBindings(),

      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: Scaffold(
        backgroundColor: MyAppColors.c1,
        body: Center(
          child: CircularProgressIndicator(
            color: MyAppColors.c1,
          ),
        ),
      ),
    );
  }
}
