import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX

class CustomPopup extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onSave;

  const CustomPopup({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Use Get.back() to close the pop-up
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onSave(controller.text);
            Get.back();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}


String? _savedValue;

void showCustomPopup() async {
  final String? result = await Get.dialog<String>(
    CustomPopup(
      title: 'Skill percentage',
      hintText: 'Enter new value...',
      onSave: (value) {
        Get.back(result: value);
      },
    ),
  );

  if (result != null) {
    // Save the value to the variable
    _savedValue = result;

    // Optionally, print the value to verify
    print('Value saved: $_savedValue');
  }
}