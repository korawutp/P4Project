import 'package:flutter/material.dart';

class CourseCodeScreen extends StatelessWidget {
  final String? classCode;

  const CourseCodeScreen({Key? key, required this.classCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Class Code')),
      body: Center(
        child: Text(
          classCode!,
          style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
