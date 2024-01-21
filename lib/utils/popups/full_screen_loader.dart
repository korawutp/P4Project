import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workproject/common/widgets/loaders/animation_loader.dart';
import 'package:workproject/utils/constants/colors.dart';

/// A utility class or managing a full-screen loading dialog.
class MyAppFullScreenLoader {
  /// Open a full-screen loading dialog with a gien text and animation.
  /// This method doesn't return everything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: the Lattie animation to be shown.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!, // Use for Get.overlayContext  overlay dialogs
        barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
        builder: (_) => PopScope(
              canPop: false, // Disable popping with the back button
              child: Container(
                color: MyAppColors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 250,
                    ),
                    MyAppAnimationLoaderWidget(
                      text: text,
                      animation: animation,
                    ),
                  ],
                ),
              ),
            ));
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
