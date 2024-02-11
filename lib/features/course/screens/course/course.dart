import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/course/controllers/course_controller.dart';
import 'package:workproject/features/course/models/course_model.dart';
import 'package:workproject/features/course/screens/course_add/course_add.dart';
import 'package:workproject/utils/constants/sizes.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: [
          IconButton(onPressed: () => controller.fetchCoursesList(), icon: const Icon(Iconsax.refresh)),
          IconButton(onPressed: () => Get.to(() => const CourseAddScreen()), icon: const Icon(Iconsax.add)),
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
            return Container(
              width: 320,
              height: 120,
              margin: const EdgeInsets.all(8), // Add margin for better spacing
              decoration: BoxDecoration(
                color: Colors.amber[700], // Adjust the color to fit your design
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // Use Expanded to handle overflow
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.courseName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis, // Handle long names
                              ),
                              Text(
                                'Created time: ${course.createdAt}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'By ${course.createdBy}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'check!',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MyAppSizes.spaceBtwItems),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
