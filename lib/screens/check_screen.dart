import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 48),

          // Hello
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Hello',
              style: GoogleFonts.notoSerif(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
