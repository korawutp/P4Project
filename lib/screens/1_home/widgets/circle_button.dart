import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onPressed;
  const CircleButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFCF1F1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Color(0xFF1A1C20),
        ),
      ),
    );
  }
}
