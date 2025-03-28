import 'package:flutter/material.dart';

// Custom Dropdown Builder
Widget buildDropdown(String label) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    items: const [
      DropdownMenuItem(value: "JOB", child: Text("JOB")),
      DropdownMenuItem(value: "INTERNSHIP", child: Text("INTERNSHIP")),
    ],
    onChanged: (value) {},
  );
}