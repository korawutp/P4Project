import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:workproject/data/repository/course/course_repository.dart';
import 'package:workproject/screens/2_classcheck/course/models/course_model.dart';
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
    final String formattedDate = DateFormat('dd MMM yyyy').format(_selectedDate);
    return Scaffold(
      backgroundColor: Color(0xFFFCF1F1),
      appBar: AppBar(
        centerTitle: true,
        title: Text('History'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CalendarTimeline(
                showYears: true,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                onDateSelected: (date) => setState(() => _selectedDate = date),
                monthColor: Color(0xFF1A1C20),
                dayColor: Color(0xFF1A1C20),
                dayNameColor: Color(0xFF1A1C20),
                activeDayColor: Color(0xFFFCF1F1),
                inactiveDayNameColor: Color(0xFFF9813A),
                activeBackgroundDayColor: Color(0xFFF9813A),
                dotsColor: const Color(0xFF1A1C20),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF1A1C20)),
              ),
              child: const Text(
                'Back to current day',
                style: TextStyle(color: Color(0xFFFCF1F1)),
              ),
              onPressed: () => setState(() => _resetSelectedDate()),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Selected date is $formattedDate',
                style: const TextStyle(color: Color(0xFF1A1C20)),
              ),
            ),
            SizedBox(height: 20),
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
                            tileColor: Color(0xFFFCF1F1), // Adjust the tile background color
                            leading: Icon(Icons.book, color: Color(0xFFF9813A)), // Example icon
                            title: Text(
                              course.courseName,
                              style: TextStyle(color: Color(0xFF1A1C20)), // Custom text color
                            ),
                            subtitle: Text(
                              'By ${course.createdByName}',
                              style: TextStyle(color: Color(0xFF1A1C20).withOpacity(0.7)), // Custom subtitle style
                            ),
                            trailing: Icon(Iconsax.printer, color: Color(0xFFF9813A)), // Trailing icon
                            onTap: () async {
                              final students = await courseRepository.fetchStudentsByCourseId(course.id);
                              await createAndDisplayPdf(context, students, course.courseName);
                            },
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Card corner radius
                          ),
                          elevation: 5, // Card elevation
                          shadowColor: Color(0xFFF9813A).withOpacity(0.5), // Card shadow color
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
