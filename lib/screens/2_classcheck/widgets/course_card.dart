import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workproject/features/course/controllers/course_controller.dart';
import 'package:workproject/screens/2_classcheck/widgets/countdowntimer.dart';

import 'package:workproject/screens/2_classcheck/widgets/popupcode_confirm.dart';
import 'package:workproject/utils/constants/colors.dart';

class CourseCard extends StatelessWidget {
  CourseCard({
    super.key,
    required this.id,
    required this.name,
    required this.createdAt,
    required this.createdBy,
  });

  final String id, name, createdBy;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    final String formattedDate =
        DateFormat('dd MMM yyyy-kk:mm').format(createdAt);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 400,
        height: 110,
        decoration: BoxDecoration(
          color: MyAppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis // Handle long names
                            ),
                        Text(
                          'Created at: ${formattedDate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'By ${createdBy}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
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
                    return SizedBox(
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
                                    builder: (BuildContext context) =>
                                        PopupCodeConfirm(id: id),
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          buttonText,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            LinearTimer(
              durationMinutes: 2, // Adjust timer duration here
              onTimerFinish: () {
                // Properly call a method to update the status
                controller.updateCourseStatus(id,
                    'Expired'); // Assuming this method exists and properly updates the course status
                print('Timer finished! Status updated to Expired.');
              },
            ),
          ],
        ),
      ),
    );
  }
}
