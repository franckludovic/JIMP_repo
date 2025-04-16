import 'package:flutter/material.dart';

class JTestField extends StatelessWidget {
  const JTestField({
    super.key,
    required this.labelText,
    this.hintText, this.controller,
  });

  final String labelText;
  final String? hintText;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: TextField(
        controller: controller,
        minLines: 12,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}