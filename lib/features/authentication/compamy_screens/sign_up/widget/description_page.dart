import 'package:flutter/material.dart';

class DescriptionEditor extends StatelessWidget {
  final TextEditingController descriptionController;

  /// Pass in your existing controller.description
  const DescriptionEditor({super.key, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    // A Card or Container to visually group the description editing
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter company description here...",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
