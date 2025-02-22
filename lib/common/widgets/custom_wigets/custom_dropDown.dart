import 'package:flutter/material.dart';

// Custom Dropdown Builder
Widget buildDropdown(String label) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    items: const [
      DropdownMenuItem(value: "Option1", child: Text("Option 1")),
      DropdownMenuItem(value: "Option2", child: Text("Option 2")),
    ],
    onChanged: (value) {},
  );
}