import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';

class PopupConfirm extends StatelessWidget {
  const PopupConfirm({super.key, required this.id});

  final id;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    return GiffyDialog.image(
      Image.network(
        "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
        height: 150,
        fit: BoxFit.cover,
      ),
      title: Text(
        'Image Animation',
        textAlign: TextAlign.center,
      ),
      content: Text(
        'This is a image animation dialog box. This library helps you easily create fancy giffy dialog.',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Get.close(1),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => controller.attemptToAccessCourse(id),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
