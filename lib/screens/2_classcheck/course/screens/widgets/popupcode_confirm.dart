import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:pinput/pinput.dart';

class PopupCodeConfirm extends StatelessWidget {
  const PopupCodeConfirm({super.key, required this.id});

  final id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    final defaultPinTheme = PinTheme(
        width: 40,
        height: 44,
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        decoration: BoxDecoration());
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return GiffyDialog.image(
      Image.network(
        "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
        height: 150,
        fit: BoxFit.cover,
      ),
      title: Text(
        'Is that you?',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Just want to make sure you're in the classroom. So please enter the code below.\nIf you've filled complete, I hope you have a wonderful day!",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Pinput(
              length: 6,
              pinAnimationType: PinAnimationType.fade,
              defaultPinTheme: defaultPinTheme,
              onCompleted: (pin) => debugPrint(pin),
              showCursor: true,
              cursor: cursor,
              preFilledWidget: preFilledWidget,
            ),
          ],
        ),
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
