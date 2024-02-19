import 'package:flutter/material.dart';
import 'package:workproject/utils/constants/colors.dart';
import 'package:workproject/utils/constants/sizes.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: MyAppColors.darkGrey,
          size: MyAppSizes.iconMd,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: MyAppText.searchCourse,
        labelStyle: const TextStyle(
          color: MyAppColors.darkGrey,
        ),
        filled: true,
        fillColor: MyAppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        isDense: true,
      ),
    );
  }
}
