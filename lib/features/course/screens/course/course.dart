import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/course/controllers/course_controller.dart';
import 'package:workproject/features/course/models/course_model.dart';
import 'package:workproject/features/course/screens/course_add/course_add.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        actions: [
          IconButton(onPressed: () => controller.fetchCoursesList(), icon: Icon(Iconsax.refresh)),
          IconButton(onPressed: () => Get.to(() => const CourseAddScreen()), icon: Icon(Iconsax.add)),
        ],
      ),
      body: Obx(() {
        if (controller.courseList.value.isEmpty) {
          return Center(child: Text('No courses found...'));
        }

        // Sort the course list based on the creation date from newest to oldest
        var sortedCourses = List<CourseModel>.from(controller.courseList.value)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return ListView.builder(
          itemCount: sortedCourses.length,
          itemBuilder: (context, index) {
            CourseModel course = sortedCourses[index];
            return ListTile(
              title: Text(course.courseName),
            );
          },
        );
        
      }),
    );
  }
}
