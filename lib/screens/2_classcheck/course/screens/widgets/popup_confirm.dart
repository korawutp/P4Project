import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/text_strings.dart';

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
        MyAppText.popupTitle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: MyAppColors.c1,
      content: Text(
        MyAppText.popupSubTitle1,
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
