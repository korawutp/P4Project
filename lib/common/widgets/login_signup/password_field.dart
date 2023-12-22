import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workproject/utils/constants/text_strings.dart';

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      decoration: InputDecoration(
        prefixIcon: Icon(Iconsax.password_check),
        labelText: MyAppText.password,
        suffixIcon: IconButton(
          icon: Icon(_isObscured ? Iconsax.eye_slash : Iconsax.eye),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}
