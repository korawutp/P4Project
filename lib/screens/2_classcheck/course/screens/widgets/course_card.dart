import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/screens/2_classcheck/course/screens/course_code.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/screens/2_classcheck/course/screens/widgets/countdowntimer.dart';
import 'package:workproject/screens/2_classcheck/course/screens/widgets/popupcode_confirm.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/device/device_utility.dart';

class CourseCard extends StatelessWidget {
  CourseCard({
    super.key,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.createdByID,
    required this.createdByName,
    this.classCode,
    required this.durationMinutes,
  });

  final String id, name, createdByID, createdByName;
  final int durationMinutes;
  final String? classCode;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    final userController = Get.put(UserController());
    final String formattedDate = DateFormat('dd MMM yyyy-kk:mm').format(createdAt);
    final currentUserID = userController.user.value.id;
    final bool isCreator = createdByID == currentUserID;
    // Using MediaQuery to get screen width
    double screenWidth = MyAppDeviceUtility.getScreenWidth(context);
    double screenHeight = MyAppDeviceUtility.getScreenHeight();

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: screenWidth,
        height: screenHeight / 7,
        decoration: BoxDecoration(
          color: Color(0xFFF9813A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFFFCF1F1),
                          ),
                          overflow: TextOverflow.ellipsis, // Handle long names
                        ),
                        Text(
                          'on ${formattedDate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFCF1F1),
                          ),
                        ),
                        Text(
                          'By ${createdByName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFFCF1F1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Obx(() {
                    final status = controller.getCourseStatus(id);
                    Color buttonColor = Colors.blue; // สีปุ่มเริ่มต้น
                    String buttonText = 'Check!'; // ข้อความปุ่มเริ่มต้น
                    if (status == 'Expired') {
                      buttonColor = Colors.red;
                      buttonText = 'Expired';
                    } else if (status == 'Checked') {
                      buttonColor = Colors.green; // สีเขียวเมื่อเช็คไปแล้ว
                      buttonText = 'Checked'; // ข้อความแสดง 'Checked'
                    }
                    return Row(
                      children: [
                        if (isCreator && classCode != null)
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: ElevatedButton(
                              child: Center(
                                // This Center widget is technically redundant but added for emphasis
                                child: Icon(Iconsax.eye, color: Color(0xFFFCF1F1)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyAppColors.black,
                                padding: EdgeInsets.zero, // Ensuring no extra padding is affecting the icon's position
                              ),
                              onPressed: () => navigateToClassCodeScreen(context),
                            ),
                          ),
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            onPressed: status != 'Expired'
                                ? () {
                                    if (status != 'Checked') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => PopupCodeConfirm(id: id),
                                      );
                                    }
                                  }
                                : null,
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFCF1F1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            LinearTimer(
              startTime: createdAt,
              endTime: createdAt.add(Duration(minutes: durationMinutes)),
              onTimerFinish: () {
                // Properly call a method to update the status
                controller.updateCourseStatus(
                    id, 'Expired'); // Assuming this method exists and properly updates the course status
                print('Timer finished! Status updated to Expired.');
              },
            ),
          ],
        ),
      ),
    );
  }

  void navigateToClassCodeScreen(BuildContext context) {
    if (classCode != null) {
      Get.to(() => CourseCodeScreen(classCode: classCode!));
    } else {
      // Handle the null case for classCode
      Get.snackbar(
        "No Class Code",
        "This course does not have a class code.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
