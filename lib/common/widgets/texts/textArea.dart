import 'package:flutter/material.dart';

class JTextArea extends StatelessWidget {
  const JTextArea({
    super.key,
    this.minAreaHeight = 7,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.label,
    this.maxAreaHeight = 7,
  });

  final int minAreaHeight;
  final int maxAreaHeight;
  final String? hintText;
  final Widget label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minAreaHeight,
      maxLines: maxAreaHeight,
      decoration: InputDecoration(
        hintText: hintText,
        label: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}