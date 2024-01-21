import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF1A1C20),
          size: 24,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search your classes",
        labelStyle: const TextStyle(
          color: Color(0xFFFFD5CD),
        ),
        filled: true,
        fillColor: Color(0xFFFCF1F1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        isDense: true,
      ),
    );
  }
}
