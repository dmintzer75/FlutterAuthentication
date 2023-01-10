import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.hintText, required this.obscureText});
  // final controller;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      // The validator receives the text that the user has entered.
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
