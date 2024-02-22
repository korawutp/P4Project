import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
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

  @override
  Widget build(BuildContext context) {
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
                            leading: Icon(Icons.book, color: MyAppColors.c3), // Example icon
                            title: Text(
                              course.courseName,
                              style: TextStyle(color: MyAppColors.c2), // Custom text color
                            ),
                            subtitle: Text(
                              'By ${course.createdByName}',
                              style: TextStyle(color: MyAppColors.c2.withOpacity(0.7)), // Custom subtitle style
                            ),
                            trailing: Icon(Iconsax.printer, color: MyAppColors.c5), // Trailing icon
                            onTap: () async {
                              final students = await courseRepository.fetchStudentsByCourseId(course.id);
                              await createAndDisplayPdf(context, students, course.courseName);
                            },
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
                    return Text("No courses found for this date.");
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
