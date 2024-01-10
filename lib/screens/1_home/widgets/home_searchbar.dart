import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 24,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: "Search your classes",
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        filled: true,
        fillColor: Colors.blue[600],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        isDense: true,
      ),
    );
  }
}
