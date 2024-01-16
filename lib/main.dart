import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// -- Entry Point of Flutter App --
Future<void> main() async {
  /// Widgets Binding
  // ignore: unused_local_variable
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// -- Run App --
  runApp(const App());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}
