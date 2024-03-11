import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
import 'package:workproject/features/personalization/controllers/user_controller/user_controller.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/document/pdf_printing.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final courseRepository = Get.put(CourseRepository());
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  /// Show a warning dialog before deleting a course
  void deleteCourseWarningPopup(String id, DateTime dateTime) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MyAppSizes.md),
      title: 'Delete Class',
      middleText:
          'Are you sure you want to delete this class permanently? This action is not reversible and all of class data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () {
          deleteCourse(id, dateTime);
          Navigator.of(Get.overlayContext!).pop(); // Close the dialog
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MyAppSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete the course and refresh UI
  Future<void> deleteCourse(String id, DateTime dateTime) async {
    await FirebaseFirestore.instance.collection('Courses').doc(id).delete();

    // Assuming this method is in a stateful widget, otherwise, you need to use another way to refresh or update the UI.
    setState(() {
      _selectedDate = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: MyAppColors.c1,
      appBar: AppBar(
        centerTitle: true,
        title: Text('History'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: MyAppSizes.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CalendarTimeline(
                showYears: true,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                onDateSelected: (date) => setState(() => _selectedDate = date),
                monthColor: MyAppColors.c2,
                dayColor: MyAppColors.c2,
                dayNameColor: MyAppColors.c4,
                activeDayColor: MyAppColors.c1,
                inactiveDayNameColor: MyAppColors.c3,
                activeBackgroundDayColor: MyAppColors.c3,
                dotsColor: MyAppColors.c2,
              ),
            ),
            const SizedBox(height: MyAppSizes.sm),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyAppColors.c2),
              ),
              child: const Text(
                'Back to current day',
                style: TextStyle(color: MyAppColors.c1),
              ),
              onPressed: () => setState(() => _resetSelectedDate()),
            ),
            const SizedBox(height: MyAppSizes.sm),
            Expanded(
              child: FutureBuilder<List<CourseModel>>(
                future: courseRepository.fetchCoursesByDate(_selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final course = snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            tileColor: MyAppColors.c1, // Adjust the tile background color
                            leading: IconButton(
                              icon: Icon(Iconsax.printer, color: MyAppColors.c3),
                              onPressed: () async {
                                final students = await courseRepository.fetchStudentsByCourseId(course.id);
                                await createAndDisplayPdf(
                                    context, students, course.courseName, course.createdAt, course.createdByName);
                              },
                            ), // Example icon
                            title: Text(
                              course.courseName,
                              style: TextStyle(color: MyAppColors.c2), // Custom text color
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              'By ${course.createdByName}',
                              style: TextStyle(color: MyAppColors.c2.withOpacity(0.7)), // Custom subtitle style
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: userController.user.value.id == course.createdByID
                                ? IconButton(
                                    icon: Icon(Iconsax.trash, color: MyAppColors.c5),
                                    onPressed: () {
                                      deleteCourseWarningPopup(course.id, course.createdAt);
                                    },
                                  )
                                : null,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Card corner radius
                          ),
                          elevation: 5, // Card elevation
                          shadowColor: MyAppColors.c2.withOpacity(0.8), // Card shadow color
                        );
                      },
                    );
                  } else {
                    return Text("No classes found for this date.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
