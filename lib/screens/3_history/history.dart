import 'package:calendar_timeline_sbk/calendar_timeline.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                firstDate: DateTime(2024),
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
                'Selected date is $_selectedDate',
                style: const TextStyle(color: Color(0xFF1A1C20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
