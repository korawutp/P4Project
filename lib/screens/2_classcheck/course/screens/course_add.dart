import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/screens/2_classcheck/course/controllers/course_controller.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/utils/constants/colors.dart';
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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: () => Get.close(1), icon: const Icon(CupertinoIcons.clear)),
          ]),
      body: SingleChildScrollView(
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
              key: controller.courseAddFormKey,
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
                    validator: (value) => MyAppValidator.validationEmptyText('Duration (Minutes)', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: MyAppText.duration,
                      prefixIcon: Icon(Iconsax.timer),
                    ),
                  ),

                  const SizedBox(height: MyAppSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Checkbox(
                            value: controller.isClassCodeEnabled.value,
                            onChanged: (bool? value) {
                              controller.toggleClassCodeEnabled(value ?? false);
                              if (value == true) {
                                controller.generateClassCode(); // Generate class code initially
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: MyAppSizes.sm),
                      Text(
                        'Generate class code (If you need)',
                      ),
                    ],
                  ),
                  const SizedBox(height: MyAppSizes.spaceBtwInputFields),
                  // Button to Generate New Class Code with Iconsax Shuffle Icon
                  Obx(() => controller.isClassCodeEnabled.value
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Class Code:',
                                ),
                                IconButton(
                                  onPressed: () => controller.generateClassCode(),
                                  icon: const Icon(Iconsax.shuffle, size: 24), // Use Iconsax shuffle icon
                                  tooltip: 'Generate New Code', // Tooltip for better UX
                                ),
                              ],
                            ),
                            Container(
                              width: 400,
                              decoration: BoxDecoration(color: MyAppColors.black),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.classCode.value,
                                    style: TextStyle(
                                        fontSize: 72,
                                        fontWeight: FontWeight.bold,
                                        color: MyAppColors.white), // Updated style
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: MyAppSizes.spaceBtwSections),
                          ],
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.addCourse(userController.user.value.id,userController.user.value.fullName),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
