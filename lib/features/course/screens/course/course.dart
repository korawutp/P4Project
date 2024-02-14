import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/course/controllers/course_controller.dart';
import 'package:workproject/features/course/models/course_model.dart';
import 'package:workproject/features/course/screens/course_add/course_add.dart';
import 'package:workproject/screens/2_classcheck/widgets/course_card.dart';

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
        if (controller.courseList.value.isEmpty) {
          return const Center(child: Text('No courses found...'));
        }

        var sortedCourses = List<CourseModel>.from(controller.courseList.value)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return ListView.builder(
          itemCount: sortedCourses.length,
          itemBuilder: (context, index) {
            CourseModel course = sortedCourses[index];
            return CourseCard(
                id: course.id, name: course.courseName, createdAt: course.createdAt, createdBy: course.createdBy);
          },
        );
      }),
    );
  }
}
