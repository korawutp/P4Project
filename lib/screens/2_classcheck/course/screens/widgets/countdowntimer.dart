import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';

class LinearTimer extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final Function onTimerFinish;

  const LinearTimer({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  _LinearTimerState createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  late int _secondsRemaining;
  late double _barWidth;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _calculateInitialValues();
    _startTimer();
  }

  void _calculateInitialValues() {
    final now = DateTime.now();
    final totalDuration = widget.endTime.difference(widget.startTime).inSeconds;
    _secondsRemaining = widget.endTime.difference(now).inSeconds;
    _barWidth = (_secondsRemaining > 0) ? _secondsRemaining / totalDuration : 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining -= 1;
          final totalDuration =
              widget.endTime.difference(widget.startTime).inSeconds;
          _barWidth =
              (_secondsRemaining > 0) ? _secondsRemaining / totalDuration : 0;
        } else {
          widget.onTimerFinish();
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed of
    super.dispose();
  }

  Widget build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60; // Get minutes from seconds
    int seconds = _secondsRemaining % 60; // Get remaining seconds

    return Stack(
      children: [
        Container(
          height: 20.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            color: MyAppColors.c2,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _barWidth,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: MyAppColors.c1,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    _secondsRemaining <= 0
                        ? "Finished"
                        : "$minutes:${seconds.toString().padLeft(2, '0')} left", // Display in mm:ss format
                    style: TextStyle(
                      color: _secondsRemaining <= 0
                          ? MyAppColors.c1
                          : MyAppColors.c2,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
