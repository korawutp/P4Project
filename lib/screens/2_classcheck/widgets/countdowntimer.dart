import 'dart:async';
import 'package:flutter/material.dart';

class LinearTimer extends StatefulWidget {
  final int durationMinutes;
  final Function onTimerFinish;

  const LinearTimer({
    Key? key,
    required this.durationMinutes,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  _LinearTimerState createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  late int _secondsRemaining;
  late double _barWidth;
  late Timer _timer; // Declare a Timer object

  @override
  void initState() {
    super.initState();
    _secondsRemaining =
        widget.durationMinutes * 60; // Convert minutes to seconds
    _barWidth = 1.0;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Update duration to seconds
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining -= 1; // Decrement by 1 second
          _barWidth = _secondsRemaining <= 0
              ? 0
              : _secondsRemaining /
                  (widget.durationMinutes * 60); // Convert back to minutes
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
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            color: Colors.black,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _barWidth,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    _secondsRemaining <= 0
                        ? "finished"
                        : "$minutes:${seconds.toString().padLeft(2, '0')} left", // Display in mm:ss format
                    style: TextStyle(
                      color:
                          _secondsRemaining <= 0 ? Colors.white : Colors.black,
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
