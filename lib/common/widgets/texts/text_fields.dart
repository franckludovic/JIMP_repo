import 'package:flutter/material.dart';

class JTestField extends StatelessWidget {
  const JTestField({
    super.key,
    required this.labelText,
    this.hintText,
  });

  final String labelText;
  final String? hintText;


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: TextField(
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