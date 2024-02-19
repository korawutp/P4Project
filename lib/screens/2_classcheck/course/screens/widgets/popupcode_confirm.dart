import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

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
            color: MyAppColors.c3,
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
            color: MyAppColors.c2,
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
        MyAppText.popupTitle,
        textAlign: TextAlign.center,
      ),
      backgroundColor: MyAppColors.c1,
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              MyAppText.popupSubTitle2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: MyAppSizes.sm,
            ),
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
