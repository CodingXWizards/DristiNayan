import 'package:flutter/material.dart';
import 'package:flutter_tailwindcss_defaults/colors.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboard;
  const Input(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboard,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        labelStyle: const TextStyle(color: TailwindColors.gray),
        fillColor: TailwindColors.coolGray.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TailwindColors.blueGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: TailwindColors.blue.shade600),
        ),
      ),
    );
  }
}
