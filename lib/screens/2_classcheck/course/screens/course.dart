import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
import 'package:workproject/screens/2_classcheck/course/screens/course_add.dart';
import 'package:workproject/screens/2_classcheck/course/screens/widgets/course_card.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/image_strings.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());

    return Scaffold(
      backgroundColor: MyAppColors.c1,
      appBar: AppBar(
        title: Text(MyAppText.courseTitle),
        actions: [
          IconButton(onPressed: () => controller.fetchCoursesList(), icon: const Icon(Iconsax.refresh)),
          IconButton(onPressed: () => Get.to(() => CourseAddScreen()), icon: const Icon(Iconsax.add)),
        ],
      ),
      body: Obx(() {
        if (controller.courseLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // // คำนวณเวลาปัจจุบันลบออก 60 นาที
          // final DateTime thirtyMinutesAgo = DateTime.now().subtract(Duration(minutes: 60));

          // // กรองคอร์สที่ยังไม่หมดอายุ
          // var activeCourses = controller.courseList.value.where((course) {
          //   // คำนวณวันและเวลาที่คอร์สจะหมดอายุ
          //   DateTime expireTime = course.createdAt.add(Duration(minutes: course.durationMinutes));
          //   return expireTime.isAfter(thirtyMinutesAgo);
          // }).toList()
          //   ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          var activeCourses = controller.getActiveCourses();
          print(activeCourses);
          if (activeCourses.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(MyAppImage.meowLoading, height: 150, width: 150),
                const SizedBox(
                  height: MyAppSizes.defaultSpace,
                ),
                Text(
                  MyAppText.noCourseFound,
                )
              ],
            ));
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
