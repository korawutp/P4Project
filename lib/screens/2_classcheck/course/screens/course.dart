import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
import 'package:workproject/screens/2_classcheck/course/screens/course_add.dart';
import 'package:workproject/screens/2_classcheck/course/screens/widgets/course_card.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());

    return Scaffold(
      backgroundColor: Color(0xFFFCF1F1),
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(onPressed: () => controller.fetchCoursesList(), icon: const Icon(Iconsax.refresh)),
          IconButton(onPressed: () => Get.to(() => CourseAddScreen()), icon: const Icon(Iconsax.add)),
        ],
      ),
      body: Obx(() {
        if (controller.courseLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // คำนวณเวลาปัจจุบันลบออก 30 นาที
          final DateTime thirtyMinutesAgo = DateTime.now().subtract(Duration(minutes: 30));

          // กรองคอร์สที่ยังไม่หมดอายุ
          var activeCourses = controller.courseList.value.where((course) {
            // คำนวณวันและเวลาที่คอร์สจะหมดอายุ
            DateTime expireTime = course.createdAt.add(Duration(minutes: course.durationMinutes));
            return expireTime.isAfter(thirtyMinutesAgo);
          }).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          if (activeCourses.isEmpty) {
            return const Center(child: Text('No courses found or all courses expired...'));
          } else {
            return ListView.builder(
              itemCount: activeCourses.length,
              itemBuilder: (context, index) {
                CourseModel course = activeCourses[index];
                return CourseCard(
                  id: course.id,
                  name: course.courseName,
                  createdAt: course.createdAt,
                  createdByID: course.createdByID,
                  createdByName: course.createdByName,
                  classCode: course.classCode,
                  durationMinutes: course.durationMinutes,
                );
              },
            );
          }
        }
      }),
    );
  }
}
