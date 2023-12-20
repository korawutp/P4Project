import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter/services.dart';

/// -- Entry Point of Flutter App --
void main() {
  /// -- Run App --
  runApp(const App());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}
