import 'package:flutter/material.dart';

// Custom TextField Builder
Widget buildTextField(String label) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}

