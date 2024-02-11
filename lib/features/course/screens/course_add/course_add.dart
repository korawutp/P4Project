import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/features/course/controllers/course_controller.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';
import 'package:workproject/utils/validators/validation.dart';

class CourseAddScreen extends StatelessWidget {
  const CourseAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    final userController = Get.put(UserController());

    return Scaffold(
      /// Custom Appbar
      appBar: AppBar(
        title: Text(
          'Add New Course',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MyAppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Create a new course for students to attend in the classroom.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // TextFields
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.courseName,
                    validator: (value) => MyAppValidator.validationEmptyText('Course Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: MyAppText.courseName,
                      prefixIcon: Icon(Iconsax.book),
                    ),
                  ),
                  const SizedBox(height: MyAppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.duration,
                    validator: (value) => MyAppValidator.validationEmptyText('Duration', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: MyAppText.duration,
                      prefixIcon: Icon(Iconsax.timer),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MyAppSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addCourse(userController.user.value.fullName),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
