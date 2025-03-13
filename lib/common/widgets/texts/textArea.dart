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
    this.backgroundcolor = Colors.transparent,
  });

  final int minAreaHeight;
  final int maxAreaHeight;
  final String? hintText;
  final Widget label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color backgroundcolor;


  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minAreaHeight,
      maxLines: maxAreaHeight,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundcolor,
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