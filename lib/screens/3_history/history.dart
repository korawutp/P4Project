import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('History'),
      ),
      body: HeatMap(
        datasets: {
          DateTime(2024, 1, 13): 3,
          DateTime(2024, 1, 14): 7,
          DateTime(2024, 1, 15): 10,
          DateTime(2024, 1, 16): 13,
          DateTime(2024, 1, 17): 6,
        },
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 20)),
        size: 40,
        textColor: Colors.orange,
        colorMode: ColorMode.opacity,
        showText: false,
        scrollable: true,
        colorsets: {
          1: Colors.green,
          2: Colors.red,
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
