import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:pinput/pinput.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class PopupCodeConfirm extends StatefulWidget {
  const PopupCodeConfirm({Key? key, required this.id}) : super(key: key);

  final id;

  @override
  _PopupCodeConfirmState createState() => _PopupCodeConfirmState();
}

class _PopupCodeConfirmState extends State<PopupCodeConfirm> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CourseController controller = Get.put(CourseController());
    final defaultPinTheme = PinTheme(
        width: 40,
        height: 44,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: MyAppColors.c2,
        ),
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
              defaultPinTheme: defaultPinTheme,
              controller: _codeController,
              length: 6,
              pinAnimationType: PinAnimationType.fade,
              showCursor: true,
              cursor: cursor,
              preFilledWidget: preFilledWidget,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            print(_codeController.text);
            controller.attemptToAccessCourseWithCode(widget.id, _codeController.text);
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
